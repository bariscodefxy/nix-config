{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
  ];
}
