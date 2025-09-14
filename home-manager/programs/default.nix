{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./apps
    ./gaming
    ./programming
    ./terminal
  ];

  home.activation.restartLxqtPanel = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PGREP=${pkgs.procps}/bin/pgrep
    PKILL=${pkgs.procps}/bin/pkill
    LXQT_PANEL=${pkgs.lxqt.lxqt-panel}/bin/lxqt-panel

    if $PGREP lxqt-panel > /dev/null; then
      echo "Restarting lxqt-panel..."
      $PKILL lxqt-panel
      nohup $LXQT_PANEL > /dev/null 2>&1 &
    fi
  '';
}
