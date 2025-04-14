{ inputs, pkgs, ... }:
{
  imports = [
    ./apps
    ./gaming
    ./programming
    ./terminal
  ];

  home.packages = with pkgs; [
    inputs.firefox.packages."${pkgs.system}".firefox-nightly-bin

    tor-browser-bundle-bin
    termius
    thunderbird
    telegram-desktop
    unrar
    unzip
    vdhcoapp
    vim
    vlc
    pywalfox-native
    libsForQt5.ark
    bitwarden-desktop
    btop
    neovim
    obs-studio
    wget
    vesktop
    filezilla
  ];
}
