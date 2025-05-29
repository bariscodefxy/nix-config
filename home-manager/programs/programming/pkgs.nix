{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    okteta
    glade
    nerd-fonts.jetbrains-mono
    nodejs_24
    python3
    python3Packages.virtualenv
  ];
}
