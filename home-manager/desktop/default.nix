{ pkgs, inputs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    caffeine
    paperwm
    pkgs.gnome-ext-hanabi
  ];
}
