{ pkgs, ... }:
{
  systemd.services.warp-dispatcher = {
    description = "Warp auto-switcher based on Wi-Fi SSID";
    wantedBy = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = with pkgs; [
      networkmanager
      cloudflare-warp
    ];
    serviceConfig = {
      Type = "simple";
      User = "bariscodefx";
      Group = "users";
      ExecStart = pkgs.writeShellScript "warp-dispatcher" ''
        while true; do
          SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d ':' -f2)
          
          case "$SSID" in
            "Redmi Note 11 Pro")
              echo "Mobil veri tespit edildi. warp aciliyor..."
              warp-cli connect
              ;;
            "eduroam")
              echo "Mobil veri tespit edildi. warp aciliyor..."
              warp-cli connect
              ;;
            *)
              echo "Bilinmeyen ağ. warp default olarak kapatiliyor..."
              warp-cli disconnect
              ;;
          esac

          sleep 5
        done
      '';
    };
  };
}
