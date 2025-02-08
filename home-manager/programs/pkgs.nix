{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    btop
    vim
    wget
    thunderbird
    prismlauncher
    vlc
    unrar
    obs-studio
    wofi
    swww
    waybar
    nemo
    pywalfox-native
    blueman
    hyprshot
  ];
}
