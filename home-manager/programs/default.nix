{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./apps
    ./compatibility
    ./desktop
    ./gaming
    ./programming
    ./terminal
  ];
}
