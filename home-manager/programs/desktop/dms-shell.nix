{ inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.default
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
  };
}
