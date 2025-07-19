{ pkgs, inputs, ... }:
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
    stable.jetbrains.idea-community-bin
    inputs.void-editor.packages.${pkgs.system}.default
    code-cursor
  ];
}
