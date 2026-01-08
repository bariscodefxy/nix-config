{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    zed-editor
    windsurf
    unstable.kiro-fhs
    code-cursor
    claude-code
    unstable.antigravity
  ];
}
