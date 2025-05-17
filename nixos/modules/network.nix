{ pkgs, ... }:
{
  networking = {
    hostName = "victus";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
