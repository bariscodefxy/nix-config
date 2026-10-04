{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins.obs-vkcapture
    mpv
    audacity
    lsp-plugins
    pear-desktop
  ];
}
