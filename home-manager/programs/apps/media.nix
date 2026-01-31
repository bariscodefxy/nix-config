{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins.obs-vkcapture
    vlc
    helvum
    lazpaint
    gimp
  ];
}
