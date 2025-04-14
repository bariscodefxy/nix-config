{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull

    brightnessctl
    mangohud
    libguestfs
    virt-viewer
  ];
}
