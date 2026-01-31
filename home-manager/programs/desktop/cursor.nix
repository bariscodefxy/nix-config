{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.lyra-cursors;
    name = "LyraX-cursors";
    size = 32;
  };
}
