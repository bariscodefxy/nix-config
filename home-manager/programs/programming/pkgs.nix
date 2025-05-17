{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    okteta
    glade
    nerd-fonts.jetbrains-mono
  ];
}
