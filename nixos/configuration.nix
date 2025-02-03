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

  system.stateVersion = "23.05";
}
