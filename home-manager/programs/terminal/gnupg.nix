{ pkgs, ... }:
{
  # Thanks to "https://kopecky.io/blog/2024-02-25-nixos-gpg-home-manager/"

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}
