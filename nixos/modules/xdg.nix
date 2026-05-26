{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
        "org.freedesktop.impl.portal.RemoteDesktop" = "hyprland";
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
