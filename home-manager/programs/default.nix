{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./apps
    ./gaming
    ./programming
    ./terminal
  ];
}
