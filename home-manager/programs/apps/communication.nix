{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cinny-desktop
    element-desktop
    teams-for-linux
    thunderbird
    wayvnc
    wlr-randr
    rustdesk
  ];
}
