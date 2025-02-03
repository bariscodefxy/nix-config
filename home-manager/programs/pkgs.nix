{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${pkgs.system}".default

    neofetch
    neovim
    wget
    thunderbird
    vesktop
    heroic
    kitty
    swww
  ];
}
