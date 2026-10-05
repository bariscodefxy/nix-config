{ ... }:
{
  imports = [
    ./victus-control-module.nix
  ];

  services.victus-control.enable = true;

  # EC fan eğrisi bozuk kartlarda (örn. 8C99) AUTO 0 RPM'de takılı kalıyor.
  # Bu servis sıcaklığa göre MANUAL pwm eğrisi uygular; AUTO/MAX'a geçmez.
  # Uygulamada mod AUTO'da bırakılmalı; MAX seçilirse servis geri çekilir.
  services.victus-control.fanCurve = {
    enable = true;
    highTemp = 80;
    lowTemp = 65;
    minPwm = 80;
    pollInterval = 5;
    settleTime = 60;
    useGpu = false;
  };
}
