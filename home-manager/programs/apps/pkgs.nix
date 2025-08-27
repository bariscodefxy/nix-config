{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    mullvad-browser
    tor-browser-bundle-bin

    mullvad-vpn
    element-desktop
    qbittorrent
    stable.android-studio
    unrar
    unzip
    filezilla
    obs-studio
    obs-studio-plugins.obs-vkcapture
    termius
    tutanota-desktop
    bitwarden-desktop
    vlc
    telegram-desktop
    vesktop
    zip
    kdePackages.kdenlive
    helvum
    lazpaint
  ];
}
