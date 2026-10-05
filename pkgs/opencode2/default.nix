{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
stdenv.mkDerivation rec {
  pname = "opencode2";
  version = "2.0.23";

  # For updating:
  #   1. Check latest version https://opencode.ai/update/api/latest/cli/npm
  #   2. Change the version tag
  #   3. Get hash: nix store prefetch-file --json \
  #        'https://registry.npmjs.org/@opencode/cli-linux-x64/-/cli-linux-x64-<version>.tgz'
  src = fetchurl {
    url = "https://registry.npmjs.org/@opencode/cli-linux-x64/-/cli-linux-x64-${version}.tgz";
    hash = "sha256-8ac5BsAxoAa5jy7wBgZQfxIsVbbrEqV9OPeUmPxlwkg=";
  };

  sourceRoot = "package";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/opencode $out/bin/opencode
    # Upstream install betiği de bu takma adı kurar (v1 ile yan yana kullanım için).
    ln -s opencode $out/bin/opencode2
    runHook postInstall
  '';

  meta = with lib; {
    description = "OpenCode v2, the open source AI coding agent (official prebuilt binary)";
    homepage = "https://opencode.ai";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "opencode";
  };
}
