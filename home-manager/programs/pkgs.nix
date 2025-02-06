{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    btop
    vim
    wget
    thunderbird
    vesktop
    prismlauncher
    vlc
    unrar
  ];
}
