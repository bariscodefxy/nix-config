{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;
  programs.zen-browser.profiles."*".extensions.packages =
    with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
      ublock-origin
      bitwarden
    ];

  home.packages = with pkgs; [
    chromium
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
    openconnect
    realvnc-vnc-viewer
  ];
}
