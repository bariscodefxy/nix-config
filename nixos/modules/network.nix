{ pkgs, ... }:
{
  networking = {
    hostName = "victus";
    networkmanager.enable = true;
    hosts = {
      "127.0.0.1" = [ "phpmyadmin.tld" ];
    };
  };

  networking.firewall = {
    enable = true;
    checkReversePath = false;
    trustedInterfaces = [ "tun0" ];
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
