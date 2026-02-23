{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    just-perfection
    arc-menu
    caffeine
    appindicator
    dash-to-dock
    vicinae
    weekly-commits
  ];
}
