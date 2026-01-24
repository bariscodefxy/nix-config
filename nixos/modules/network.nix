{ pkgs, ... }:
{
  networking = {
    hostName = "victus";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
  };

  networking.firewall = {
    enable = false;
  };
}
