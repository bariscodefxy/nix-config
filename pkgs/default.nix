pkgs: {
  phpmyadmin = pkgs.callPackage ./phpmyadmin/package.nix { };
  hp-wmi-fan-and-backlight-control =
    {
      kernel ? pkgs.linuxPackages.kernel,
    }:
    pkgs.callPackage ./hp-wmi-fan-and-backlight-control/default.nix {
      inherit kernel;
    };
  victus-control = pkgs.callPackage ./victus-control/default.nix { };
  xash3d-fwgs = pkgs.callPackage ./xash3d/package.nix { };
  hlsdk = pkgs.callPackage ./hlsdk/package.nix { };
  rustdesk-bin = pkgs.callPackage ./rustdesk-bin/default.nix { };
}
