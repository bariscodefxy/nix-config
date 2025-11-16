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
}
