{ config, pkgs, ... }:

let
  # Sabit sing-box ayarlarını buraya alıyoruz (IP hariç)
  singBoxConfig = {
    log = {
      level = "info";
    };
    inbounds = [
      {
        type = "tun";
        # Modern sürümlerde parametre adı 'address' oldu ve liste bekler
        address = [ "172.19.0.1/30" ];
        auto_route = true;
        strict_route = true;
        sniff = true;
        stack = "system";
      }
    ];
    outbounds = [
      {
        type = "socks";
        tag = "proxy-out";
        server = "@GATEWAY_IP@";
        server_port = 10808;
        udp_over_tcp = true;
      }
      {
        type = "direct";
        tag = "direct-out";
      }
      {
        type = "dns";
        tag = "dns-out";
      }
    ];
    route = {
      rules = [
        {
          protocol = "dns";
          action = "route";
          outbound = "dns-out";
        }
        {
          ip_is_private = true;
          action = "route";
          outbound = "direct-out";
        }
      ];
      auto_detect_interface = true;
    };
    dns = {
      servers = [
        {
          tag = "google-dns";
          address = "8.8.8.8";
        }
      ];
      strategy = "prefer_ipv4";
    };
  };

  # JSON dosyasını oluşturuyoruz
  configFile = pkgs.writeText "sing-box-template.json" (builtins.toJSON singBoxConfig);

in
{
  environment.systemPackages = [ pkgs.sing-box ];

  # Standart servisi devre dışı bırakıp kendi özel servisimizi yazıyoruz
  systemd.services.sing-box = {
    description = "Sing-box with Dynamic Gateway IP";
    after = [
      "network.target"
      "network-online.target"
    ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    environment = {
      ENABLE_DEPRECATED_SPECIAL_OUTBOUNDS = "true";
    };

    serviceConfig = {
      ExecStartPre = pkgs.writeShellScript "prepare-config" ''
        export PATH=$PATH:${pkgs.iproute2}/bin:${pkgs.gawk}/bin:${pkgs.gnused}/bin

        # Gateway IP'sini bul
        GATEWAY_IP=$(ip route show default | awk '/default/ {print $3}' | head -n1)

        if [ -z "$GATEWAY_IP" ]; then
          echo "Gateway bulunamadı!"
          exit 1
        fi

        # Şablonu al ve IP'yi içine yerleştirip /run altına yaz
        sed "s/@GATEWAY_IP@/$GATEWAY_IP/g" ${configFile} > /run/sing-box-dynamic.json
        echo "Konfigürasyon hazırlandı: $GATEWAY_IP"
      '';

      ExecStart = "${pkgs.sing-box}/bin/sing-box run -c /run/sing-box-dynamic.json";

      # TUN ayarları için gerekli yetkiler
      Capabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW";
      User = "root";
      Restart = "on-failure";
    };
  };
}
