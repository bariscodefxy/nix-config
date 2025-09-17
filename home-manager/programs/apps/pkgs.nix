{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    brave
    tor-browser
    element-desktop
    filezilla
    obs-studio
    obs-studio-plugins.obs-vkcapture
    termius
    vlc
    vesktop
    kdePackages.kdenlive
    helvum
    lazpaint
    hackneyed
    mullvad-vpn
  ];
}
