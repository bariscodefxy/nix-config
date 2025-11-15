{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./desktop.nix
    ./modules
    ./services
  ];

  system.stateVersion = "25.05";
}
