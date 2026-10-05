{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    quickshell

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
