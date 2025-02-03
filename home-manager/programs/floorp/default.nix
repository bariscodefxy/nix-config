{ pkgs, ... }:
{
  programs.floorp = {
    enable = true;

    profiles = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };
}
