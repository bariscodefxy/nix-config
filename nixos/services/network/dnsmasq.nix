{ ... }: {
  networking.nameservers = [ "127.0.0.1" ];

  services.dnsmasq = {
    enable = true;
    settings = {
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;
      no-poll = true;
      bind-interfaces = true;
      interface = "lo";
      cache-size = 1000;
      server = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
      listen-address = "127.0.0.1";
    };
  };
}
