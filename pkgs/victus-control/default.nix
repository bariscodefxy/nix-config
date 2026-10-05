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
  makeWrapper
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
    find . -type f -name "meson.build" -exec sed -i \
      -e "s|'/usr/|'$out/|g" \
      -e "s|'/etc/|'$out/etc/|g" {} +
  '';

  postInstall = ''
    # 1. Shell betiklerindeki standart yolları (örneğin #!/bin/bash) Nix store yollarıyla değiştirir
    if [ -d "$out/bin" ]; then
      patchShebangs $out/bin
    fi

    # 2. Servis uygulamasına nvidia-smi ve kendi betiklerini bulabilmesi için PATH verir
    # - $out/bin: set-fan-speed.sh gibi paketin kendi araçları için
    # - /run/current-system/sw/bin: nvidia-smi ve diğer sistem komutları için
    wrapProgram $out/bin/victus-backend \
      --prefix PATH : "$out/bin:/run/current-system/sw/bin:/run/wrappers/bin"
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
