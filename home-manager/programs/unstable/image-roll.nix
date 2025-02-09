{ pkgs, ... }:
{
  home.packages = with pkgs; [
    image-roll
  ];
}
