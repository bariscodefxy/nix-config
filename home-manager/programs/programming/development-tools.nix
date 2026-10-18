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

    # Android IDE. Ships its own bundled JDK, so nothing else is needed to
    # run it; it does not provide an Android SDK or the platform tools.
    android-studio

    # Android platform tools (adb, fastboot, sdkmanager). Without these the
    # IDE can build but cannot see a device or pull an SDK.
    android-tools
  ];
}
