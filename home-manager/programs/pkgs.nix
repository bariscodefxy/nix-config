{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    neovim
    btop
    vim
    wget
    thunderbird
    vesktop
    heroic
    kitty
    swww
    firefox
  ];
}
