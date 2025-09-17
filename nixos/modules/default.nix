{ ... }:
{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./garbage.nix
    ./graphics.nix
    ./network.nix
    ./package.nix
    ./programs.nix
    ./system.nix
    ./user.nix
    ./virtualisation.nix
  ];
}
