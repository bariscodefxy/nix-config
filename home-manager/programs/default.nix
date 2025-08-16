{ pkgs, inputs, ... }:
{
  imports = [
    ./apps
    ./gaming
    ./programming
    ./security
    ./terminal
  ];
}
