{ plasma-manager, ... }:

{
  imports = [ plasma-manager.homeManagerModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
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
