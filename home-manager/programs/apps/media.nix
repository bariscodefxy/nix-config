{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins.obs-vkcapture
    mpv
    vlc
    lazpaint
    gimp
    audacity
    lsp-plugins
  ];
}
