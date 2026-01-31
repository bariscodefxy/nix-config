{ pkgs, ... }:
{
  imports = [
    ./input.nix
    ./keybinds.nix
    ./variables.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
