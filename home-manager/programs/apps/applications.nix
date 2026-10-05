{ pkgs, ... }:
{
  imports = [
    ./browsers
    ./ai.nix
    ./media.nix
    ./communication.nix
    ./productivity.nix
    ./network.nix
    ./terminal.nix
    ./audio.nix
  ];
}
