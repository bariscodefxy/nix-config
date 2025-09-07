{ pkgs, ... }:
{
  networking = {
    hostName = "victus";
    networkmanager.enable = true;
  };
}
