{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.lyra-cursors;
    name = "LyraB-cursors";
    size = 32;
  };
}
