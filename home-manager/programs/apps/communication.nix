{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wayvnc
    wlr-randr
    zapzap
    thunderbird
    telegram-desktop
  ];
}
