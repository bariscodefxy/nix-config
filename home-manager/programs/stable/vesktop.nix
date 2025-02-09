{ pkgs, ... }:
{
  home.packages = with pkgs.stable; [
    vesktop # Streaming not work in Electron 34. That's why `vesktop` is in stable channel.
  ];
}
