{ ... }:
{
  imports = [
    ./network.nix
    ./system.nix
    ./user.nix
    ./boot.nix
    ./package.nix
    ./hardware.nix
    ./game.nix
    ./garbage.nix
    ./virtualization.nix
  ];
}
