{ lib, stdenv, fetchurl, autoPatchelfHook, dpkg, makeDesktopItem, copyDesktopItems, gtk3
, libappindicator-gtk3, libXtst, pulseaudio, gst_all_1, linux-pam, openssl
}:

let
  version = "1.4.6";
in
stdenv.mkDerivation {
  pname = "rustdesk-bin";
  inherit version;

  src = fetchurl {
    url = "https://github.com/rustdesk/rustdesk/releases/download/${version}/rustdesk-${version}-x86_64.deb";
    hash = "sha256-DaRtenslIoLe1TI/dDGaEMH6cnEAHTspez3vQVyMjwQ=";
  };

  nativeBuildInputs = [ autoPatchelfHook dpkg copyDesktopItems ];

  buildInputs = [
    gtk3
    libappindicator-gtk3
    libXtst
    pulseaudio
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    linux-pam
    openssl
  ];

  unpackPhase = ''
    mkdir -p build
    dpkg-deb -x $src build
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp -r build/usr/share/rustdesk $out/share/rustdesk
    cp -r build/usr/share/applications $out/share/
    cp -r build/usr/share/icons $out/share/
    cp -r build/usr/share/polkit-1 $out/share/
    ln -s $out/share/rustdesk/rustdesk $out/bin/rustdesk
  '';

  dontPatchELF = false;
  dontStrip = true;

  meta = with lib; {
    description = "Virtual / remote desktop infrastructure for everyone!";
    homepage = "https://rustdesk.com";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = [ ];
  };
}
