{ pkgs, config, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;

      powerManagement = {
        enable = true;
        #finegrained = true;
      };

      prime = {
        #offload = {
        #  enable = true;
        #  enableOffloadCmd = true;
        #};
        sync.enable = true;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.xserver.videoDrivers = [
    #"modesetting"
    "nvidia"
  ];
}
