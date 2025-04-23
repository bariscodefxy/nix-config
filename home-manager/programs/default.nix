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
    ungoogled-chromium

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
    zip
    lshw
    ticktick
    element-desktop
    wpsoffice
    gimp
    mullvad-vpn
    wireguard-tools
    qbittorrent
  ];
}
