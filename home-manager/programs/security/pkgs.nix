{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thc-hydra
    lynis
    maltego
    aircrack-ng
    bettercap
    sqlmap
    nmap
    wireshark
  ];
}
