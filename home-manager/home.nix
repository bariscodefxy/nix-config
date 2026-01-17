{
  outputs,
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./desktop
    ./programs
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.nix-vscode-extensions.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "bariscodefx";
    homeDirectory = "/home/bariscodefx";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";

  home.activation.linkDesktopApplications = {
    after = [
      "writeBoundary"
      "createXdgUserDirectories"
    ];
    before = [ ];
    data = ''
      rm -rf ${config.xdg.dataHome}/nix-desktop-files/applications
      mkdir -p ${config.xdg.dataHome}/nix-desktop-files/applications
      cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/nix-desktop-files/applications/
    '';
  };
  xdg.enable = true;
  xdg.systemDirs.data = [ "${config.xdg.dataHome}/nix-desktop-files" ];
}
