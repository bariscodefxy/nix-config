{ pkgs, ... }:
{
  networking = {
    hostName = "victus";
    networkmanager.enable = true;
    # proxy = {
    #   default = "socks5://10.205.71.246:1080/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  networking.firewall = {
    enable = true;
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
