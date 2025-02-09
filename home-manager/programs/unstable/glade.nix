{ pkgs, ... }:
{
  home.packages = with pkgs; [
    glade
  ];
}
