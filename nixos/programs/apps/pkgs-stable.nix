{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.stable; [
    electron
  ];
}
