{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins.obs-vkcapture
    vlc
    lazpaint
    gimp
    audacity
    lsp-plugins
  ];
}
