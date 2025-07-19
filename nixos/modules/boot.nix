{ pkgs, config, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];
  boot.kernelModules = [ "snd-hda-codec-realtek" "hp_wmi" "v4l2loopback" ];
  boot.extraModulePackages = [ config.hardware.nvidia.package config.boot.kernelPackages.v4l2loopback pkgs.snd-hda-codec-realtek pkgs.betel-wmi-management ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
}
