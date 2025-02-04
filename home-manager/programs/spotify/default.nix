{ inputs, pkgs, ... }:
# let
#   spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
# in
{
  programs.spotify-player.enable = true;

  # imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # programs.spicetify = {
  #   enable = true;
  #   enabledExtensions = with spicePkgs.extensions; [
  #     adblockify
  #     hidePodcasts
  #     shuffle
  #   ];
  #   theme = spicePkgs.themes.ziro;
  #   colorScheme = "mocha";
  # };
}
