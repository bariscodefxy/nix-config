{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    lunar-client
    inputs.prismlauncher.packages.${system}.prismlauncher
  ];
}
