{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans 10";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
