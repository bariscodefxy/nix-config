{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunar
    file-roller
  ];
}
