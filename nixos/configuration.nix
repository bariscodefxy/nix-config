{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./services
  ];

  system.stateVersion = "25.11";
}
