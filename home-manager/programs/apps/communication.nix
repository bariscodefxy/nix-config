{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cinny-desktop
    element-desktop
    teams-for-linux
    thunderbird
    pkgs.anydesk
  ];
}
