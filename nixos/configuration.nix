{ ... }:
{
  imports = [
    # ./disko.nix # I don't use right now
    ./hardware-configuration.nix
    ./modules
    ./services
  ];

  system.stateVersion = "25.11";
}
