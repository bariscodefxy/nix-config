{ pkgs, ... }:
{
  home.packages = with pkgs; [
    okteta
  ];
}
