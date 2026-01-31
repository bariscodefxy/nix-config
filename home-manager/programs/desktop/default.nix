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
    ./cursor.nix
    ./niri
    ./dms-shell.nix
  ];

}
