{ pkgs, ... }:
{
  home.packages = with pkgs; [
    whitesur-kde
    whitesur-icon-theme
    whitesur-gtk-theme
    whitesur-cursors
  ];
}
