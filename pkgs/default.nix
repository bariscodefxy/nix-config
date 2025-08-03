pkgs: {
  snd-hda-codec-realtek = pkgs.callPackage ./snd-hda-codec-realtek-patched.nix {
    kernel = pkgs.linuxPackages_zen.kernel;
  };
  hp-wmi-fan-control = pkgs.callPackage ./hp-wmi-fan-control.nix {
    kernel = pkgs.linuxPackages_zen.kernel;
  };
}
