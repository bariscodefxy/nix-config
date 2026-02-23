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
    gtk3
    gsettings-desktop-schemas
  ];

  environment.extraInit = ''
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  '';
}
