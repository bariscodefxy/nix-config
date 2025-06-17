{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

with pkgs;
let
  patchDesktop =
    pkg: appName: from: to:
    lib.hiPrio (
      pkgs.runCommand "$patched-desktop-entry-for-${appName}" { } ''
        ${coreutils}/bin/mkdir -p $out/share/applications
        ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      ''
    );
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in
{
  home.packages = with pkgs; [
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher

    (GPUOffloadApp steam "steam")
    steam
    heroic
    lutris
    bottles
    protonup-qt
    protontricks
    vinegar
  ];
}
