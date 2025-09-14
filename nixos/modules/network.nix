{ ... }:
{
  networking = {
    hostName = "victus";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };
}
