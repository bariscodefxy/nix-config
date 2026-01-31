{ ... }:
{
  services.create_ap.enable = true;
  services.create_ap.settings = {
    INTERNET_IFACE = "wlo1";
    PASSPHRASE = "12345678";
    SSID = "iw7260";
    WIFI_IFACE = "wlo1";
    FREQ_BAND = "2.4";
    GATEWAY = "192.168.12.1";
  };
}
