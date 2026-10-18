{inputs, ...}: {
  # The ArtCraft Crafting Apps are installed per-user through Home Manager
  # (home-manager/programs/apps/craftapps.nix). Only the font link stays here.
  #
  # The apps' text tools look for fonts only under /usr/share/fonts and do not
  # use fontconfig, and Home Manager cannot write into /usr. That link is the
  # one thing their Home Manager module does not provide, so it has to happen
  # at the NixOS level.
  #
  # Deliberately NOT importing inputs.nix-craftapps.nixosModules.default: with
  # programs.craftapps.enable set it also pushes the packages into
  # environment.systemPackages, which is a system-wide install. Re-importing it
  # here would install pdfcraft twice.
  fonts.fontDir.enable = true;

  systemd.tmpfiles.rules = [
    "d /usr/share 0755 root root -"
    "L+ /usr/share/fonts - - - - /run/current-system/sw/share/X11/fonts"
  ];
}
