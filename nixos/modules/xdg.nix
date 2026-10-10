{ pkgs, lib, desktop, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    config = lib.mkIf (desktop == "niri") {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        "org.freedesktop.impl.portal.Settings" = "gnome";
      };
    };

    extraPortals = lib.mkIf (desktop == "niri") [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
