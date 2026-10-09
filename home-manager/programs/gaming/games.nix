{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    inputs.macoblox.packages.${pkgs.stdenv.hostPlatform.system}.macoblox
  ];
}
