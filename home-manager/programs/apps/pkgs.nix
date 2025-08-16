{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tor-browser-bundle-bin
    ungoogled-chromium
    inputs.zen-browser.packages.${pkgs.system}.default

    wireguard-tools
    mullvad-vpn
    stable.gimp
    element-desktop
    qbittorrent
    stable.android-studio
    flameshot
    protonvpn-gui
    protonvpn-cli
    unrar
    unzip
    yt-dlp
    filezilla
    obs-studio
    obs-studio-plugins.obs-vkcapture
    termius
    thunderbird
    bitwarden-desktop
    vlc
    telegram-desktop
    neovim
    vesktop
    zip
    remmina
    realvnc-vnc-viewer
    kdePackages.kdenlive
    helvum
  ];
}
