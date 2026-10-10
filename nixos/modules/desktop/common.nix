{ pkgs, ... }:
{
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  security.rtkit.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  security.wrappers = {
    gsr-kms-server = {
      source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
      permissions = "u+rx,g+rx,o+rx";
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    ddcutil
    lm_sensors
  ];
}
