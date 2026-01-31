{ ... }:
{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./fonts.nix
    ./garbage.nix
    ./graphics.nix
    ./network.nix
    ./nixpkgs-config.nix
    ./programs.nix
    ./system.nix
    ./user.nix
    ./virtualisation.nix
    ./xdg.nix
  ];
}
