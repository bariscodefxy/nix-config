{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
    obs-studio
    obs-studio-plugins.obs-vkcapture
    mpv
    audacity
    lsp-plugins
    pear-desktop
  ];
}
