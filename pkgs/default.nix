pkgs: {
  phpmyadmin = pkgs.callPackage ./phpmyadmin/pkg.nix { configFile = null; };
}
