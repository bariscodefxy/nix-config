{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    brave
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
    vmware-workstation
  ];
}
