{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    bottles
  ];
}
