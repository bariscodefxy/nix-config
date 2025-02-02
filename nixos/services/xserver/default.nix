{ ... }:
{
  # set keyboard map
  services.xserver = {
    xkb.layout = "us,tr";
    xkbOptions = "grp:win_space_toggle";
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
}
