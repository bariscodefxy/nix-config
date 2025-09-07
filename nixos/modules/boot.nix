{ pkgs, config, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];
  boot.extraModulePackages = [
    config.hardware.nvidia.package
    config.boot.kernelPackages.v4l2loopback

    # (WIP)
    # pkgs.vmware-host-modules-workstation-17-6-0
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
}
