{ pkgs, config, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "kvm.enable_virt_at_load=0"
  ];
  boot.kernelModules = [ "tun" ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
}
