{ pkgs, ... }:
{
  home.packages = with pkgs; [
    filezilla
    qbittorrent
    remmina
    proton-vpn
    wireguard-tools
  ];
}
