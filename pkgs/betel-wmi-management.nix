{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  name = "betel-wmi-management-${version}-${kernel.version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "bariscodefxy";
    repo = "betel-wmi-management";
    rev = "d630e960042230b612a1708775349db9dcfaf388";
    sha256 = "0xmn8vaxvlz2d7xl83g87pz288a2simzzjp5aqllir2wrxi7p790";
  };

  preConfigure = ''
    export INSTALL_MOD_PATH="$out"
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    homepage = "https://github.com/betelqeyza/betel-wmi-management";
    description = "Betel WMI Management";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [
      betelqeyza
    ];
    platforms = [
      "i686-linux"
      "x86_64-linux"
    ];
  };
}