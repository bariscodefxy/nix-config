{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
  gamedir ? "valve",
  enableGoldsourceSupport ? true,
  enableVgui ? false,
  enableVoicemgr ? false,
  enableBugfixes ? false,
  enableCrowbarIdleAnim ? false,
}:

stdenv.mkDerivation {
  pname = "fwgs-hlsdk";
  version = "2025-02-01";

  nativeBuildInputs = with pkgs; [ cmake ];

  src = fetchFromGitHub {
    owner = "FWGS";
    repo = "hlsdk-portable";
    rev = "afe7d33e15c75fa61fc5a8e287bc484146e7c377";
    sha256 = "sha256-yfJ+CQctC+WSEw8v0Wk78zFtNPnqrCEnNa5dr53DN70=";
    fetchSubmodules = enableVgui;
  };

  cmakeFlags =
    let
      optionals = lib.optionals;
      optional = (cond: val: optionals cond [ val ]);
      cmakeBool = (x: if x then "ON" else "OFF");
    in
    [
      "-DUSE_VGUI=${cmakeBool enableVgui}"
      "-DGOLDSOURCE_SUPPORT=${cmakeBool enableGoldsourceSupport}"
      "-DUSE_VOICEMGR=${cmakeBool enableVoicemgr}"
      "-DBARNACLE_FIX_VISIBILITY=${cmakeBool enableBugfixes}"
      "-DCROWBAR_DELAY_FIX=${cmakeBool enableBugfixes}"
      "-DCROWBAR_FIX_RAPID_CROWBAR=${cmakeBool enableBugfixes}"
      "-DGAUSS_OVERCHARGE_FIX=${cmakeBool enableBugfixes}"
      "-DTRIPMINE_BEAM_DUPLICATION_FIX=${cmakeBool enableBugfixes}"
      "-DHANDGRENADE_DEPLOY_FIX=${cmakeBool enableBugfixes}"
      "-DWEAPONS_ANIMATION_TIMES_FIX=${cmakeBool enableBugfixes}"
      "-DCROWBAR_IDLE_ANIM=${cmakeBool enableCrowbarIdleAnim}"
    ]
    ++ (optional (gamedir != "valve") "-DGAMEDIR=${gamedir}")
    ++ (optional stdenv.is64bit "-D64BIT=ON");

  meta = with lib; {
    description = "Portable Half-Life SDK. GoldSource and Xash3D. Crossplatform.";
    homepage = "https://github.com/FWGS/hlsdk-portable";
    license = with licenses; [ unfree ];
    # maintainers = with maintainers; [ chayleaf ];
  };
}
