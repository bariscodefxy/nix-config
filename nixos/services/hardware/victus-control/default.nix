{ ... }:
{
  imports = [
    ./victus-control-module.nix
  ];

  services.victus-control.enable = true;
}
