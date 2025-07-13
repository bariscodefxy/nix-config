{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  name = "sna-hda-codec-realtek-patched-${version}-${kernel.version}";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Vilez0";
    repo = "realtek-alc245-fixups";
    rev = "9facc8bd5269dda8200888fced4f3dd976293a34";
    sha256 = "0i82d1rg2yklnv2b6ffj7444gy9y5px5b9xkcwis0gb8sg547z9d";
  };

  preConfigure = ''
    export INSTALL_MOD_PATH="$out"
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    homepage = "https://github.com/Vilez0/realtek-alc245-fixups";
    description = "Patched snd-hda-codec-realtek";
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