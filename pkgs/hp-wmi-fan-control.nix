{
  stdenv,
  lib,
  kernel,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "hp-wmi-fan-and-backlight-control";
  version = "0.0.4-unstable-2026-09-06";

  src = fetchFromGitHub {
    owner = "TUXOV";
    repo = "hp-wmi-fan-and-backlight-control";
    rev = "2816846199328da03f88dd8f3d1b852e5b999058";
    sha256 = "sha256-HjJM5ZXeegephhKwPXieUIy587iCPYVrVQAxl6y9GFE=";
  };

  postPatch = ''
    sed -i 's@depmod -a@@g' Makefile
    # 6.18 headers no longer define ACPI_AC_CLASS (historically "ac_adapter").
    # The two power-source event filters below are its only users.
    substituteInPlace hp-wmi.c \
      --replace-quiet 'ACPI_AC_CLASS' '"ac_adapter"'
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installFlags = [ "INSTALL_MOD_PATH=$(out)" ];

  meta = with lib; {
    description = "Patched HP WMI kernel module with manual fan control and zoned keyboard RGB for Omen/Victus laptops";
    homepage = "https://github.com/TUXOV/hp-wmi-fan-and-backlight-control";
    license = licenses.gpl2Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
