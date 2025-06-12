{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    vscode
    okteta
    glade
    nerd-fonts.jetbrains-mono
    nodejs_24
    python3
    python3Packages.virtualenv
    jetbrains.idea-community-bin
  ];
}
