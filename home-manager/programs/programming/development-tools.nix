{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt
    nerd-fonts.jetbrains-mono
    claude-code
    php
    php84Packages.composer
    nodejs_24
    ffmpeg
  ];
}
