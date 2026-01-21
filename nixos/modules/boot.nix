{ pkgs, config, ... }:
{
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "kvm.enable_virt_at_load=0"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
    (pkgs.hp-wmi-fan-and-backlight-control { kernel = config.boot.kernelPackages.kernel; })
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
}
