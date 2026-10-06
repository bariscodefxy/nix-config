{ pkgs, ... }:
{
  # Thanks to "https://kopecky.io/blog/2024-02-25-nixos-gpg-home-manager/"

  # gpg
  programs.gpg.enable = true;

  # gpg-agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
