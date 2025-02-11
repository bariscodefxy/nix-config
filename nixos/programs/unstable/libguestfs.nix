{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libguestfs
  ];
}
