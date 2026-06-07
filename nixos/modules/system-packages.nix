{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    steam
    badvpn
    protonup-qt
    stdenv.cc
    gnumake
    victus-control
    gtk3
  ];
}
