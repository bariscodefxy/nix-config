{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    claude-code
    php
    php84Packages.composer
    nodejs_24
    ffmpeg
    opencode
  ];
}
