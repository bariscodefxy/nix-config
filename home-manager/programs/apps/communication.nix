{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wayvnc
    wlr-randr
  ];
}
