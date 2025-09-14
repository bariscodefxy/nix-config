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
    steam
  ];
}
