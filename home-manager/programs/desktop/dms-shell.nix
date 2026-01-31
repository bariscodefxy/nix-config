{ inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.default
    inputs.dms.homeModules.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
  };
}
