{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  gtk4,
  wrapGAppsHook4,
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
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Batuhan4";
    repo = "victus-control";
    rev = "5aadf66ee88f5e42e8f847154dd491d503d22c01";
    sha256 = "sha256-dggZwK0ngH8l7QlvgpsOFxZ09AUp2OSZIC4+lptG9KQ=";
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
    # Meson: mutlak '/etc/...' ve '/usr/...' kurulum dizinlerini prefix'e göreli
    # hale getir, böylece $out altına kurulurlar.
    substituteInPlace backend/meson.build \
      --replace-quiet "'/etc/systemd/system'" "'etc/systemd/system'" \
      --replace-quiet "'/usr/lib/victus-control'" "'lib/victus-control'" \
      --replace-quiet "'/etc/udev/rules.d'" "'etc/udev/rules.d'" \
      --replace-quiet "'/etc/tmpfiles.d'" "'etc/tmpfiles.d'"
    substituteInPlace hotkey/meson.build \
      --replace-quiet "'/usr/lib/systemd/user'" "'lib/systemd/user'" \
      --replace-quiet "'/etc/udev/rules.d'" "'etc/udev/rules.d'"

    # Backend C++: yardımcı betikler ve sudo için sabit /usr/bin yollarını düzelt.
    # Yardımcılar paketin kendi $out/bin dizinine, sudo NixOS wrapper'ına bağlanır.
    substituteInPlace backend/src/fan.cpp \
      --replace-quiet '"/usr/bin/sudo"' '"/run/wrappers/bin/sudo"' \
      --replace-quiet '"/usr/bin/set-fan-mode.sh"' '"'$out'/bin/set-fan-mode.sh"' \
      --replace-quiet '"/usr/bin/set-fan-speed.sh"' '"'$out'/bin/set-fan-speed.sh"'
    substituteInPlace backend/src/keyboard.cpp \
      --replace-quiet '"/usr/bin/sudo"' '"/run/wrappers/bin/sudo"' \
      --replace-quiet '"/usr/bin/set-rgb-zone.sh"' '"'$out'/bin/set-rgb-zone.sh"' \
      --replace-quiet '"/usr/bin/set-rgb-zones.sh"' '"'$out'/bin/set-rgb-zones.sh"'

    # Servis ve desktop dosyalarındaki sabit ExecStart yollarını düzelt.
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
    # Meson yardımcı betikleri kurmuyor (upstream install.sh manuel kopyalıyor),
    # bu yüzden 4 betiği $out/bin altına kendimiz kuruyoruz.
    install -D -m 0755 ${src}/backend/src/set-fan-mode.sh $out/bin/set-fan-mode.sh
    install -D -m 0755 ${src}/backend/src/set-fan-speed.sh $out/bin/set-fan-speed.sh
    install -D -m 0755 ${src}/backend/src/set-rgb-zone.sh $out/bin/set-rgb-zone.sh
    install -D -m 0755 ${src}/backend/src/set-rgb-zones.sh $out/bin/set-rgb-zones.sh

    patchShebangs $out/bin $out/lib/victus-control

    # NixOS services.udev.packages kuralları $out/lib/udev/rules.d altında arar,
    # meson ise etc altına kuruyor. Her ikisinde de bulunsun.
    mkdir -p $out/lib/udev/rules.d
    cp $out/etc/udev/rules.d/*.rules $out/lib/udev/rules.d/

    # Backend nvidia-smi'yi `popen("timeout 3 nvidia-smi ...")` ile PATH üzerinden
    # çağırıyor. Nix store'daki coreutils (timeout) + sürücüden gelen nvidia-smi
    # için impure /run yolları gerekli.
    wrapProgram $out/bin/victus-backend \
      --prefix PATH : "${lib.makeBinPath [ coreutils kmod findutils gnugrep gnused gawk bash ]}:$out/bin:/run/opengl-driver/bin:/run/current-system/sw/bin:/run/wrappers/bin"

    # Healthcheck dkms/modprobe/lsmod/find gibi araçları PATH'ten çağırıyor.
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
