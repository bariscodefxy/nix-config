{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    vscode
    okteta
    glade
    nerd-fonts.jetbrains-mono
  ];
}
