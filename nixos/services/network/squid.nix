{ ... }:
{
  services.squid = {
    enable = false;
    proxyPort = 3128;
    extraConfig = ''
      acl localnet src 172.16.1.0/24
      http_access allow localnet
      http_access allow localhost
    '';
  };
}
