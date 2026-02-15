{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  addonPkgs = inputs.firefox-addons.packages.${pkgs.system};

  allowUnfreeAddon =
    pkg:
    pkg.overrideAttrs (old: {
      meta = (old.meta or { }) // {
        unfree = false;
        license = lib.licenses.free;
      };
    });
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;
  programs.zen-browser.profiles = {
    "*" = {
      extensions.packages = [
        addonPkgs.ublock-origin
        addonPkgs.bitwarden
        addonPkgs.darkreader
      ];
    };
  };
}
