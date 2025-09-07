{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lshw
    wget
    btop
    vim
    dnsutils
  ];
}
