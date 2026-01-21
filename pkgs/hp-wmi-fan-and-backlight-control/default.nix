{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kmod,
}:
stdenv.mkDerivation rec {
  name = "hp-wmi-fan-and-backlight-control-${version}-${kernel.modDirVersion}";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "TUXOV";
    repo = "hp-wmi-fan-and-backlight-control";
    rev = "4981849";
    sha256 = "+EMHVwfZ6iLqBczpLyPoEGlRzcnP5X7FkznVYC2shT8=";
  };

  patches = [ ./new-hp-wmi-fan-and-backlight-control-NixOS.patch ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KVERSION=${kernel.modDirVersion}"
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];
  installPhase = ''
    runHook preInstall

    # We call make on the KERNEL's build directory (-C) 
    # and point it back to our current source (M=$PWD)
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$PWD \
      INSTALL_MOD_PATH=$out \
      modules_install

    runHook postInstall
  '';

  meta = with lib; {
    description = "NixOS port of HP WMI fan and backlight control kernel module";
    homepage = "https://github.com/TUXOV/hp-wmi-fan-and-backlight-control";
    license = licenses.gpl2;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
