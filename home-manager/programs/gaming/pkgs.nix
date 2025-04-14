{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    heroic
    prismlauncher
    lutris
    bottles
    protonup-qt
  ];
}
