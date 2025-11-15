{ ... }:
{
  services.redsocks = {
    enable = true;
    redsocks = [
      {
        doNotRedirect = [
          "-d 172.21.0.0/16"
        ];
        port = 23456;
        proxy = "172.21.48.159:1080";
        redirectCondition = true;
        type = "socks5";
      }
    ];
  };
}
