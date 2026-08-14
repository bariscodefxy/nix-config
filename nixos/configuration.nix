{ ... }:
{
  imports = [
    ./disko.nix
    ./modules
    ./services
  ];

  system.stateVersion = "25.11";
}
