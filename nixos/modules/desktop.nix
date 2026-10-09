{ pkgs, inputs, ... }:
{
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
  ];

  programs.niri = {
    enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    # NOTE: Do NOT set GDK_BACKEND here; it breaks portal-gnome screencasting.
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
    swaylock
    xwayland-satellite
    polkit_gnome
    brightnessctl
    ddcutil
    lm_sensors
  ];
}
