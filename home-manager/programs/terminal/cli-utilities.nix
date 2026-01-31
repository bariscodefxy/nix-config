{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lshw
    wget
    btop
    dnsutils
    unrar
    unzip
    nmap
    gnome-terminal
  ];
}
