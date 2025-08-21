{ pkgs, ... }:
{
  services.xserver.enable = true; # optional
  services.displayManager.sddm = {
    enable = true;
    theme = "WhiteSur-dark";
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs; [
    whitesur-kde # also add here for sddm
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
  ];
}
