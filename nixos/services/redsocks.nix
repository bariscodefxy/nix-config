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
        proxy = "10.205.71.246:1080";
        redirectCondition = true;
        type = "socks5";
      }
    ];
  };
}
