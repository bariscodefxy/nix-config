{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    zed-editor
    windsurf
    kiro-fhs
    code-cursor
    claude-code
    php
    php84Packages.composer
    nodejs_24
    ffmpeg
    arduino-ide
    antigravity-fhs
  ];
}
