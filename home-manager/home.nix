{ ... }:
{
  imports = [
    ./user.nix
    ./overlays.nix
    ./system.nix
    ./programs
    ./services
  ];
}
