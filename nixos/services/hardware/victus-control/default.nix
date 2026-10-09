{ ... }:
{
  imports = [
    ./victus-control-module.nix
  ];

  services.victus-control.enable = true;

  # On boards with broken EC fan curves (e.g. 8C99), AUTO gets stuck at 0 RPM.
  # This service applies a MANUAL pwm curve based on temperature; does not switch to AUTO/MAX.
  # The UI mode should remain AUTO; if MAX is chosen, the service backs off.
  services.victus-control.fanCurve = {
    enable = true;
    highTemp = 80;
    lowTemp = 65;
    minPwm = 80;
    pollInterval = 5;
    settleTime = 60;
    useGpu = false;
  };
}
