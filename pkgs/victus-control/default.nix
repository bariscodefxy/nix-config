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
}:

stdenv.mkDerivation rec {
  pname = "victus-control";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Vilez0";
    repo = "victus-control";
    rev = "3cf7d22921a24adb7fe6e806c912679ef81f8c77";
    sha256 = "sha256-vpRbDA8gfCDx9NJX4EVqPWa49RAU73ZpHu4Y14C6CvQ=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    systemd
  ];

  postPatch = ''
    substituteInPlace backend/meson.build \
      --replace-fail "install_dir: '/etc/systemd/system'" \
                     "install_dir: join_paths(get_option('prefix'), 'lib', 'systemd', 'system')"

    substituteInPlace frontend/meson.build \
      --replace-fail "install_dir: '/usr/share/applications'" \
                     "install_dir: join_paths(get_option('prefix'), 'share', 'applications')"
  '';

  meta = with lib; {
    description = "Fan control and RGB keyboard settings for HP Victus and Omen laptops";
    homepage = "https://github.com/Vilez0/victus-control";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
    mainProgram = "victus-control";
  };
}
