{ pkgs, ... }:
{
  home.packages = with pkgs; [
    filezilla
    termius
    qbittorrent
    realvnc-vnc-viewer
  ];
}
