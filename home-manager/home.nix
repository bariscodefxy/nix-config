{
  outputs,
  ...
}:
{
  imports = [
    ./programs
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };

  home = {
    username = "bariscodefx";
    homeDirectory = "/home/bariscodefx";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
