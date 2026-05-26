{ pkgs, ... }:
{
  home.packages = with pkgs; [
    element-desktop
    teams-for-linux
    thunderbird
    pkgs.rustdesk-bin
  ];
}
