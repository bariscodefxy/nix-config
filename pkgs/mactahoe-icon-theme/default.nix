{ stdenvNoCC, lib, fetchFromGitHub, gtk3 }:

stdenvNoCC.mkDerivation {
  pname = "mactahoe-icon-theme";
  version = "0-unstable-2026-09-10";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-icon-theme";
    rev = "839848b9a8a38a92a6936e30c4abe35cc6f2546d";
    hash = "sha256-NAahlBOYub0QlqkYStamoCbyWh+H5JG/iFm4Ws9EU3A=";
  };

  nativeBuildInputs = [ gtk3 ];

  # Upstream install.sh also installs cursor themes, but cursors/dist-light
  # is missing from the repo so that step fails. Icons only here; cursors
  # stay managed separately.
  postPatch = ''
    substituteInPlace install.sh \
      --replace-fail 'install_theme && install_cursor_theme' 'install_theme'
  '';

  installPhase = ''
    runHook preInstall
    patchShebangs install.sh
    # -n is required: stdenv exports $name (the derivation name), which would
    # otherwise override the script's MacTahoe default via ${name:-...}.
    ./install.sh -n MacTahoe -d $out/share/icons
    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    test -d $out/share/icons/MacTahoe
    test -d $out/share/icons/MacTahoe-dark
    test -f $out/share/icons/MacTahoe-dark/index.theme
  '';

  meta = {
    description = "macOS Tahoe style icon theme for Linux";
    homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
