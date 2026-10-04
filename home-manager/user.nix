{ ... }:
{
  home = {
    username = "baris";
    homeDirectory = "/home/baris";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
