{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    fontconfig
    noto-fonts
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.enable = true;
}
