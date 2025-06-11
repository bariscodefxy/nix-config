{ ... }:
{
  networking.nameservers = [ "77.90.5.73#adguard.bariscodefx.tr" ];
  #networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "77.90.5.73#adguard.bariscodefx.tr" ];
    dnsovertls = "true";
  };
}
