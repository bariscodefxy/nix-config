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

    # Git GUI client. Electron-based, so it runs through XWayland on this
    # Wayland session rather than natively.
    github-desktop
  ];
}
