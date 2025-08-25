{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lshw
    wget
    btop
    dnsutils
    qjackctl
    flatpak
    quickemu
    wezterm
  ];
}
