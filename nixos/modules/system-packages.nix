{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    badvpn
    protonup-qt
    stdenv.cc
    gnumake
    #victus-control
    gtk3
  ];
}
