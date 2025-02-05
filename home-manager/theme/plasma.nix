{ pkgs, ... }:
{
  programs.plasma.workspace = {
    lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";
    wallpaper = "${pkgs.whitesur-kde}/share/wallpapers/WhiteSur-dark/contents/images/3840x2160.jpg";
  };
}
