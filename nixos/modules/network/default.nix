{ pkgs, ... }:
{
  networking = {
    hostName = "victus";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
