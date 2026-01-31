{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    nautilus
  ];
}
