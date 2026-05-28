pkgs: {
  phpmyadmin = pkgs.callPackage ./phpmyadmin/package.nix { };
  victus-control = pkgs.callPackage ./victus-control/default.nix { };
  hlsdk = pkgs.callPackage ./hlsdk/package.nix { };
}
