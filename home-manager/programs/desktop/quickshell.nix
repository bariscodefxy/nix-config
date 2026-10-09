{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    quickshell
    grim
    slurp
    swappy
    wl-clipboard
    libnotify
    gpu-screen-recorder
    app2unit
    cliphist
    fuzzel
  ];
}
