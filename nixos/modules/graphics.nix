{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # For modern Intel CPU's
      intel-media-driver # Enable Hardware Acceleration
      vpl-gpu-rt # Enable QSV
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
