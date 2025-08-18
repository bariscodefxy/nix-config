{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    mullvad-browser
    inputs.zen-browser.packages.${pkgs.system}.default
    ungoogled-chromium
    tor-browser-bundle-bin

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
