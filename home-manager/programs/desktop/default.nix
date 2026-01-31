{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri

    #./stylix.nix
    ./niri
    ./dms-shell.nix
  ];

}
