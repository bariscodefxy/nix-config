pkgs: {
  vmware-host-modules-workstation-17-6-0 =
    pkgs.callPackage ./vmware-host-modules-workstation-17.6.0.nix
      {
        kernel = pkgs.linuxPackages_zen.kernel;
      };
}
