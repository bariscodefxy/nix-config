{ ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelModules = [
    "vfio-pci"
    "kvm-intel"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];
}
