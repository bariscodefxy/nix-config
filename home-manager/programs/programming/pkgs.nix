{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    inputs.void-editor.packages.${pkgs.system}.default
  ];
}
