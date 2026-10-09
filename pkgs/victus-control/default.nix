{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  wrapGAppsHook4,
  gtk4,
  systemd,
  makeWrapper,
  coreutils,
  kmod,
  findutils,
  gnugrep,
  gnused,
  gawk,
  bash,
}:

stdenv.mkDerivation rec {
  pname = "victus-control";
  version = "1.2.1-unstable-2026-03-31";

  src = fetchFromGitHub {
    owner = "Batuhan4";
    repo = "victus-control";
    rev = "87a03046f49fcbfdfc1fc910b86556e43187c3a4";
    hash = "sha256-5iFh+5j+mSkg19p736p1k1u0kQy+7871tM+0vLq7Npk=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    makeWrapper
  ];

  buildInputs = [
    gtk4
    systemd
  ];

  postPatch = ''
    # Meson: make absolute '/etc/...' and '/usr/...' install paths relative
    # to prefix so they install under $out.
    substituteInPlace backend/meson.build \
      --replace-quiet "'/etc/systemd/system'" "'etc/systemd/system'" \
      --replace-quiet "'/usr/lib/victus-control'" "'lib/victus-control'" \
      --replace-quiet "'/etc/udev/rules.d'" "'etc/udev/rules.d'" \
      --replace-quiet "'/etc/tmpfiles.d'" "'etc/tmpfiles.d'"
    substituteInPlace hotkey/meson.build \
      --replace-quiet "'/usr/lib/systemd/user'" "'lib/systemd/user'" \
      --replace-quiet "'/etc/udev/rules.d'" "'etc/udev/rules.d'"

    # Backend C++: fix hardcoded /usr/bin paths for helper scripts and sudo.
    # Helpers point to $out/bin, sudo points to NixOS wrapper.
    substituteInPlace backend/src/fan.cpp \
      --replace-quiet '"/usr/bin/sudo"' '"/run/wrappers/bin/sudo"' \
      --replace-quiet '"/usr/bin/set-fan-mode.sh"' '"'$out'/bin/set-fan-mode.sh"' \
      --replace-quiet '"/usr/bin/set-fan-speed.sh"' '"'$out'/bin/set-fan-speed.sh"'
    substituteInPlace backend/src/keyboard.cpp \
      --replace-quiet '"/usr/bin/sudo"' '"/run/wrappers/bin/sudo"' \
      --replace-quiet '"/usr/bin/set-rgb-zone.sh"' '"'$out'/bin/set-rgb-zone.sh"' \
      --replace-quiet '"/usr/bin/set-rgb-zones.sh"' '"'$out'/bin/set-rgb-zones.sh"'

    # Fix hardcoded ExecStart paths in service and desktop files.
    substituteInPlace backend/victus-backend.service \
      --replace-quiet 'ExecStart=/usr/bin/victus-backend' 'ExecStart='$out'/bin/victus-backend'
    substituteInPlace backend/victus-healthcheck.service \
      --replace-quiet 'ExecStart=/usr/lib/victus-control/victus-healthcheck.sh' 'ExecStart='$out'/lib/victus-control/victus-healthcheck.sh'
    substituteInPlace hotkey/victus-hotkeyd.service \
      --replace-quiet 'ExecStart=/usr/bin/victus-hotkeyd' 'ExecStart='$out'/bin/victus-hotkeyd'
    substituteInPlace frontend/victus-control.desktop \
      --replace-quiet 'Exec=/usr/bin/victus-control' 'Exec='$out'/bin/victus-control'
  '';

  postInstall = ''
    # Meson does not install helper scripts (upstream install.sh copies them manually),
    # so install all 4 scripts to $out/bin ourselves.
    install -D -m 0755 ${src}/backend/src/set-fan-mode.sh $out/bin/set-fan-mode.sh
    install -D -m 0755 ${src}/backend/src/set-fan-speed.sh $out/bin/set-fan-speed.sh
    install -D -m 0755 ${src}/backend/src/set-rgb-zone.sh $out/bin/set-rgb-zone.sh
    install -D -m 0755 ${src}/backend/src/set-rgb-zones.sh $out/bin/set-rgb-zones.sh

    patchShebangs $out/bin $out/lib/victus-control

    # NixOS services.udev.packages searches under $out/lib/udev/rules.d,
    # but meson installs to etc. Keep rules in both places.
    mkdir -p $out/lib/udev/rules.d
    cp $out/etc/udev/rules.d/*.rules $out/lib/udev/rules.d/

    # Backend calls nvidia-smi via popen("timeout 3 nvidia-smi ...") on PATH.
    # Nix store coreutils (timeout) + nvidia-smi from driver require impure /run paths.
    wrapProgram $out/bin/victus-backend \
      --prefix PATH : "${lib.makeBinPath [ coreutils kmod findutils gnugrep gnused gawk bash ]}:$out/bin:/run/opengl-driver/bin:/run/current-system/sw/bin:/run/wrappers/bin"

    # Healthcheck calls dkms/modprobe/lsmod/find from PATH.
    wrapProgram $out/lib/victus-control/victus-healthcheck.sh \
      --prefix PATH : "${lib.makeBinPath [ coreutils kmod findutils gnugrep gnused gawk bash ]}:/run/current-system/sw/bin:/run/wrappers/bin"
  '';

  meta = with lib; {
    description = "Linux fan control and keyboard lighting for HP Victus/Omen with Arch/Fedora installers and GNOME Shell support";
    homepage = "https://github.com/Batuhan4/victus-control";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
    mainProgram = "victus-control";
  };
}
