pkgs: {
  phpmyadmin = pkgs.callPackage ./phpmyadmin/pkg.nix { configFile = null; };
  hp-wmi-fan-and-backlight-control =
    {
      kernel ? pkgs.linuxPackages.kernel,
    }:
    pkgs.callPackage ./hp-wmi-fan-and-backlight-control/default.nix {
      inherit kernel;
    };
}
