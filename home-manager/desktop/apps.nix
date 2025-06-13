{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core GNOME applications
    nautilus
    gnome-terminal
    gedit
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-weather
    gnome-maps
    gnome-contacts
    gnome-music
    gnome-photos
    totem
    evince
    gnome-software
    gnome-system-monitor
    gnome-disk-utility
    gnome-font-viewer
    gnome-screenshot
    gnome-logs

    # Extensions and utilities
    gnomeExtensions.topiconsfix
    gnome-tweaks
    gnome-extension-manager
  ];
}
