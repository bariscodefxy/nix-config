{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./programs
    ./modules
    ./services
  ];

  system.stateVersion = "24.11";
}
