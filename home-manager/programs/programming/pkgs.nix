{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    zed-editor
    windsurf
    pkgs.kiro # pkgs/kiro/package.nix in the root
    code-cursor
  ];
}
