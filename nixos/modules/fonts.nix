{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    dejavu_fonts
    cantarell-fonts
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono" "DejaVu Sans Mono" ];
      sansSerif = [ "Cantarell" "Noto Sans" "DejaVu Sans" ];
      serif = [ "Noto Serif" "DejaVu Serif" ];
    };
    hinting = {
      enable = true;
      style = "slight";
    };
    subpixel = {
      rgba = "rgb";
      lcdfilter = "light";
    };
  };
}
