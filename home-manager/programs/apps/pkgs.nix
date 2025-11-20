{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    ungoogled-chromium
    tor-browser
    element-desktop
    filezilla
    obs-studio
    obs-studio-plugins.obs-vkcapture
    termius
    vlc
    vesktop
    kdePackages.kdenlive
    helvum
    lazpaint
    hackneyed
    mullvad-vpn
    qbittorrent
    teams-for-linux
    thunderbird
    gimp
    teamspeak3
    teamspeak6-client
    libreoffice
  ];
}
