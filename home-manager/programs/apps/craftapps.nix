{inputs, ...}: {
  imports = [inputs.nix-craftapps.homeManagerModules.default];

  programs.craftapps = {
    enable = true;

    # All 12 ArtCraft apps. Each one has an x86_64-linux source in apps.json,
    # so nothing is silently skipped; the module derives the package list from
    # every name in that file.
    enableAll = true;
  };

  # No `linkFonts` equivalent here: the Home Manager module only installs the
  # packages. The apps' text tools look for fonts under /usr/share/fonts and do
  # not consult fontconfig, and that path can only be linked at the NixOS
  # level -- see nixos/modules/craftapps.nix.
}
