{ pkgs, ... }:
{
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
