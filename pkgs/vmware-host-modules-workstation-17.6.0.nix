{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:
let
  fs = lib.fileset;
  sourceFiles = ./vmware-host-modules-workstation-17.6.0;
in
stdenv.mkDerivation rec {
  name = "vmware-host-modules-workstation-${version}-${kernel.version}";
  version = "17.6.0";

  src = fs.toSource {
    root = ./vmware-host-modules-workstation-17.6.0;
    fileset = sourceFiles;
  };

  preConfigure = ''
    export INSTALL_MOD_PATH="$out"
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "MODDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/misc"
  ];

  meta = with lib; {
    description = "VMware host modules for workstation 17.6.0";
    maintainers = with maintainers; [
      bariscodefx
    ];
    platforms = [
      "i686-linux"
      "x86_64-linux"
    ];
  };
}
