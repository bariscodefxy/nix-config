{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./desktop
    ./modules
    ./services
  ];

  system.stateVersion = "25.05";
}
