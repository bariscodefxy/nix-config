{ config, pkgs, ... }:

let
  xrayConfig = {
    log = {
      level = "warning";
    };
    inbounds = [
      {
        tag = "tproxy-in";
        port = 12345;
        protocol = "dokodemo-door";
        settings = {
          network = "tcp,udp";
          followRedirect = true;
        };
        streamSettings = {
          sockopt = {
            tproxy = "tproxy";
          };
        };
      }
    ];
    outbounds = [
      {
        tag = "proxy-out";
        protocol = "socks";
        settings = {
          servers = [
            {
              address = "@GATEWAY_IP@";
              port = 10808;
            }
          ];
        };
        streamSettings = {
          sockopt = {
            udp_over_tcp = true;
          };
        };
      }
    ];
  };

  configFile = pkgs.writeText "xray-tproxy.json" (builtins.toJSON xrayConfig);

  setupScript = pkgs.writeShellScript "xray-tproxy-setup" ''
    set -e
    export PATH=$PATH:${pkgs.iproute2}/bin:${pkgs.gawk}/bin:${pkgs.gnused}/bin:${pkgs.coreutils}/bin

    IPTABLES=${pkgs.iptables}/bin/iptables
    IP=${pkgs.iproute2}/bin/ip

    GATEWAY_IP=$($IP route show default | ${pkgs.gawk}/bin/awk '/default/ {print $3}' | ${pkgs.coreutils}/bin/head -n1)

    if [ -z "$GATEWAY_IP" ]; then
      echo "Gateway IP bulunamadı!"
      exit 1
    fi

    # Generate config with gateway IP
    sed "s/@GATEWAY_IP@/$GATEWAY_IP/g" ${configFile} > /run/xray-tproxy.json
    echo "Gateway: $GATEWAY_IP"

    # Routing table for marked packets
    $IP rule add fwmark 1 table 100 2>/dev/null || true
    $IP route add local 0.0.0.0/0 dev lo table 100 2>/dev/null || true

    # ---- PREROUTING chain (traffic from other hosts) ----
    $IPTABLES -t mangle -N XRAY_TPROXY 2>/dev/null || true
    $IPTABLES -t mangle -F XRAY_TPROXY
    $IPTABLES -t mangle -D PREROUTING -j XRAY_TPROXY 2>/dev/null || true
    $IPTABLES -t mangle -A PREROUTING -j XRAY_TPROXY

    # Skip private/local addresses
    for subnet in 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16 172.16.0.0/12 192.168.0.0/16 224.0.0.0/4 240.0.0.0/4; do
      $IPTABLES -t mangle -A XRAY_TPROXY -d "$subnet" -j RETURN
    done

    # Skip traffic to the SOCKS5 proxy server (phone)
    $IPTABLES -t mangle -A XRAY_TPROXY -d "$GATEWAY_IP" -j RETURN

    # TPROXY redirect TCP+UDP
    $IPTABLES -t mangle -A XRAY_TPROXY -p tcp -j TPROXY --on-port 12345 --tproxy-mark 1
    $IPTABLES -t mangle -A XRAY_TPROXY -p udp -j TPROXY --on-port 12345 --tproxy-mark 1

    # ---- OUTPUT chain (traffic from local processes) ----
    $IPTABLES -t mangle -N XRAY_OUT 2>/dev/null || true
    $IPTABLES -t mangle -F XRAY_OUT
    $IPTABLES -t mangle -D OUTPUT -j XRAY_OUT 2>/dev/null || true
    $IPTABLES -t mangle -A OUTPUT -j XRAY_OUT

    # Skip private/local addresses
    for subnet in 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16 172.16.0.0/12 192.168.0.0/16 224.0.0.0/4 240.0.0.0/4; do
      $IPTABLES -t mangle -A XRAY_OUT -d "$subnet" -j RETURN
    done

    # Skip traffic to the SOCKS5 proxy server (phone)
    $IPTABLES -t mangle -A XRAY_OUT -d "$GATEWAY_IP" -j RETURN

    # Mark local traffic for TProxy routing
    $IPTABLES -t mangle -A XRAY_OUT -p tcp -j MARK --set-mark 1
    $IPTABLES -t mangle -A XRAY_OUT -p udp -j MARK --set-mark 1

    echo "TProxy kuralları hazırlandı."
  '';

  teardownScript = pkgs.writeShellScript "xray-tproxy-teardown" ''
    export PATH=$PATH:${pkgs.iproute2}/bin:${pkgs.gawk}/bin:${pkgs.gnused}/bin:${pkgs.coreutils}/bin

    IPTABLES=${pkgs.iptables}/bin/iptables
    IP=${pkgs.iproute2}/bin/ip

    $IPTABLES -t mangle -D PREROUTING -j XRAY_TPROXY 2>/dev/null || true
    $IPTABLES -t mangle -F XRAY_TPROXY 2>/dev/null || true
    $IPTABLES -t mangle -X XRAY_TPROXY 2>/dev/null || true

    $IPTABLES -t mangle -D OUTPUT -j XRAY_OUT 2>/dev/null || true
    $IPTABLES -t mangle -F XRAY_OUT 2>/dev/null || true
    $IPTABLES -t mangle -X XRAY_OUT 2>/dev/null || true

    $IP rule del fwmark 1 table 100 2>/dev/null || true
    $IP route del local 0.0.0.0/0 dev lo table 100 2>/dev/null || true

    rm -f /run/xray-tproxy.json
    echo "TProxy kuralları temizlendi."
  '';
in
{
  environment.systemPackages = with pkgs; [ xray iptables iproute2 ];

  systemd.services.xray-tproxy = {
    description = "xray-core TProxy transparent proxy";
    after = [ "network.target" "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStartPre = setupScript;
      ExecStart = "${pkgs.xray}/bin/xray run -c /run/xray-tproxy.json";
      ExecStopPost = teardownScript;
      Restart = "on-failure";
      CapabilityBoundingSet = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
      AmbientCapabilities = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_NET_RAW" ];
      User = "root";
    };
  };
}
