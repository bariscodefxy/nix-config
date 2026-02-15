{ ... }:
{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./fonts.nix
    ./garbage.nix
    ./graphics.nix
    ./network.nix
    ./nixpkgs-config.nix
    ./program-config.nix
    ./system-packages.nix
    ./system.nix
    ./user.nix
    ./virtualisation.nix
    ./xdg.nix
  ];
}
