{ inputs, pkgs, ... }:
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

  home.packages = with pkgs; [
    # screenshot tools
    grim
    slurp
    swappy
    wl-clipboard
    libnotify

    # screen recording
    gpu-screen-recorder
    app2unit

    # clipboard utility
    cliphist
    fuzzel
  ];
}
