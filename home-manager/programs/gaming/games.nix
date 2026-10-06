{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    inputs.macoblox.packages.${pkgs.system}.macoblox
  ];
}
