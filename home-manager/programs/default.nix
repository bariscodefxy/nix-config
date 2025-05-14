{ pkgs, ... }:
{
  imports = [
    ./apps
    ./gaming
    ./programming
    ./security
    ./terminal
  ];

  home.packages = with pkgs; [
    librewolf-bin
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
    dnsutils
    ticktick
    element-desktop
    wpsoffice
    gimp
    mullvad-vpn
    wireguard-tools
    qbittorrent
    android-studio
    realvnc-vnc-viewer
    jdk23
    apple-cursor
    flameshot
    protonvpn-gui
    protonvpn-cli
    unstable.windsurf
  ];
}
