{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./desktop
    ./programs
    ./modules
    ./services
  ];

  system.stateVersion = "25.05";
}
