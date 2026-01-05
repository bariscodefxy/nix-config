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
        proxy = "10.207.204.180:1080";
        redirectCondition = true;
        type = "socks5";
      }
    ];
  };
}
