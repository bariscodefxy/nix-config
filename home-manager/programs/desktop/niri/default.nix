{ pkgs, ... }:
{
  imports = [
    ./input.nix
    ./keybinds.nix
    ./misc.nix
    ./variables.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
