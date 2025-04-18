{ pkgs, ... }:
{
  systemd.services.zapret-dispatcher = {
    description = "Zapret auto-switcher based on Wi-Fi SSID";
    wantedBy = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = with pkgs; [ networkmanager ];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "zapret-dispatcher" ''
        while true; do
          SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d ':' -f2)

          case "$SSID" in
            "Redmi Note 11 Pro")
              echo "Mobil veri tespit edildi. zapret kapatiliyor..."
              systemctl stop zapret
              ;;
            "eduroam")
              echo "Okul agi tespit edildi. zapret kapatiliyor..."
              systemctl stop zapret
              ;;
            "GSBWIFI")
              echo "Yurt agi tespit edildi. zapret kapatiliyor..."
              systemctl stop zapret
              ;;
            *)
              echo "Bilinmeyen ağ. zapret default olarak aciliyor..."
              systemctl stop zapret
              systemctl start zapret
              ;;
          esac

          sleep 5
        done
      '';
    };
  };
}
