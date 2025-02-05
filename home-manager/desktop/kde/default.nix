{ pkgs, plasma-manager, ... }:

{
  imports = [ plasma-manager.homeManagerModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";
      wallpaper = "${pkgs.whitesur-kde}/share/wallpapers/WhiteSur-dark/contents/images/3840x2160.jpg";
    };

    kscreenlocker = {
      autoLock = false;
    };

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = false;
        powerProfile = "performance";
      };
      battery = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        powerProfile = "balanced";
      };
      lowBattery = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        powerProfile = "powerSaving";
      };
    };
  };
}
