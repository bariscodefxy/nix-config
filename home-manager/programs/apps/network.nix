{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qbittorrent
    remmina
    protonvpn-gui
    wireguard-tools
  ];
}
