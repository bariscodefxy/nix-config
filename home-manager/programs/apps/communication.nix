{ pkgs, ... }:
{
  home.packages = with pkgs; [
    element-desktop
    teams-for-linux
    thunderbird
    teamspeak6-client
  ];
}
