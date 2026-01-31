{ ... }:
{
  home = {
    username = "bariscodefx";
    homeDirectory = "/home/bariscodefx";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
