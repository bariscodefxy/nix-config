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
    enable = true;
    checkReversePath = false;
    allowedTCPPorts = [
      80
      443
      8080
      3000
      5000
      8888
      5173
    ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
}
