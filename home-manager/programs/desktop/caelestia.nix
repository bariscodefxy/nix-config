{ inputs, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
      environment = [
        "CAELESTIA_WALLPAPERS_DIR=/home/bariscodefx/Pictures/Wallpapers"
      ];
    };
  };
}
