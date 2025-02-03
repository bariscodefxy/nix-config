{ pkgs, ... }:
{
  boot.kernelModules = [ "nouveau" ];
  boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      mesa.drivers
    ];
  };
}
