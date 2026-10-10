{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    swaylock
    xwayland-satellite
    polkit_gnome
  ];
}
