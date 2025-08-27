{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    nodejs_24
    python3
    python3Packages.virtualenv
    inputs.void-editor.packages.${pkgs.system}.default
    go
    jdk23
  ];
}
