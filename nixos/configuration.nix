{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./desktop
    ./programs
    ./modules
    ./services
  ];

  system.stateVersion = "24.11";
}
