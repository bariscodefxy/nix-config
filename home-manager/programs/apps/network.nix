{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qbittorrent
    remmina
    proton-vpn
    wireguard-tools
  ];
}
