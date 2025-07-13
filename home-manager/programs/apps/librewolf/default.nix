{ pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
  };
  stylix.targets.librewolf.profileNames = [ "default" ];
}
