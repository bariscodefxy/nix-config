{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    inter-nerdfont
  ];

  gtk = {
    enable = true;
    font = {
      name = "Inter Nerd Font";
      size = 11;
    };

    theme = {
      name = "linea-nord-color";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "black"; };
    };

    cursorTheme = {
      name = "Vimix-cursors";
      package = pkgs.vimix-cursors;
      size = 28;
    };
  };

  home.pointerCursor = {
    name = "Vimix-cursors";
    package = pkgs.vimix-cursors;
    size = 28;
  };
}
