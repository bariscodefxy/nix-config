{ ... }:
{
  services.redsocks = {
    enable = true;
    redsocks = [
      {
        doNotRedirect = [
          "-d 10.185.0.0/16"
        ];
        port = 23456;
        proxy = "10.185.224.248:1080";
        redirectCondition = true;
        type = "socks5";
      }
    ];
  };
}
