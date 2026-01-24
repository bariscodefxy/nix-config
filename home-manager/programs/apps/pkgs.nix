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
      darkreader
    ];

  home.packages = with pkgs; [
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
    qbittorrent
    teams-for-linux
    thunderbird
    gimp
    teamspeak6-client
    libreoffice
    realvnc-vnc-viewer
  ];
}
