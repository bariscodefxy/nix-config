{ pkgs, config, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];
  boot.extraModulePackages = [ config.hardware.nvidia.package ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
    grub.useOSProber = true;
    grub.minegrub-theme = {
      enable = true;
      splash = "100% Flakes!";
      background = "background_options/1.8  - [Classic Minecraft].png";
      boot-options-count = 4;
    };
  };
}
