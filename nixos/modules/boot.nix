{ pkgs, config, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
}
