{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    neovim
    btop
    vim
    wget
    thunderbird
    vesktop
    kitty
    swww
    prismlauncher
    mangohud
  ];
}
