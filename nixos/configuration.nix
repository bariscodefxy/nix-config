{ ... }:
{
  imports = [
    # ./disko.nix
    ./hardware-configuration.nix
    ./modules
    ./services
  ];

  system.stateVersion = "26.05";
}
