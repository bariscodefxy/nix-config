pkgs: {
  snd-hda-codec-realtek = pkgs.callPackage ./snd-hda-codec-realtek-patched.nix {
    kernel = pkgs.linuxPackages_zen.kernel;
  };
  betel-wmi-management = pkgs.callPackage ./betel-wmi-management.nix {
    kernel = pkgs.linuxPackages_zen.kernel;
  };
}
