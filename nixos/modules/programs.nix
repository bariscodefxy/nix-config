{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    bottles
    steam
    badvpn
    v2rayn
    protonup-qt
    stdenv.cc
    gnumake
    victus-control
  ];
}
