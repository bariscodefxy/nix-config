pkgs: {
  phpmyadmin = pkgs.callPackage ./phpmyadmin/package.nix { };
  victus-control = pkgs.callPackage ./victus-control/default.nix { };
  hlsdk = pkgs.callPackage ./hlsdk/package.nix { };
  opencode2 = pkgs.callPackage ./opencode2/default.nix { };
  mactahoe-icon-theme = pkgs.callPackage ./mactahoe-icon-theme/default.nix { };
}
