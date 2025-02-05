{ plasma-manager, ... }:

{
  imports = [ plasma-manager.homeManagerModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    input = {
      touchpads = [
        {
          disableWhileTyping = false;
          enable = true;
          naturalScroll = true;
          tapToClick = true;
          name = "ELAN07C8:00 04F3:3298 Touchpad";
          productId = "3298";
          vendorId = "04F3";
        }
      ];
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
