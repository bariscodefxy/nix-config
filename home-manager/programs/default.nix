{
  pkgs,
  lib,
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
