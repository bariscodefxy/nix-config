{ ... }:
{
services.avahi = {
  enable = true;
  nssmdns4 = true; # Enables IPv4 mDNS resolution
  publish = {
    enable = true;
    addresses = true;
    workstation = true;
  };
};

# Open firewall for mDNS
networking.firewall.allowedUDPPorts = [ 5353 ];
}
