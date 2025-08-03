{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  name = "hp-wmi-fan-control-${version}-${kernel.version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "bariscodefxy";
    repo = "hp-wmi-fan-control";
    rev = "987e41e4074c12b86c00adc5270887b3797adc2c";
    sha256 = "0k0h0hpq1vyxsl9wj80j0vrcmmffsrib0fnyildyr94wifr1wjwh";
  };

  preConfigure = ''
    export INSTALL_MOD_PATH="$out"
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    homepage = "https://github.com/Vilez0/hp-wmi-fan-control";
    description = "HP fan control driver test";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [
      Vilez0
    ];
    platforms = [
      "i686-linux"
      "x86_64-linux"
    ];
  };
}