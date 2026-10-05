{ pkgs, ... }:
{
  # greetd + tuigreet starts the compositor without a display-manager
  # session, so nothing may pull in graphical-session.target.
  # xdg-desktop-portal has Requisite=graphical-session.target and can never start without it,
  # which breaks portal features (Discord screen share, portal file
  # chooser, screenshots). This keepalive binds the target to the login
  # session via dependency (allowed despite RefuseManualStart) and keeps
  # it active (StopWhenUnneeded won't stop it while bound).
  systemd.user.services.graphical-session-keepalive = {
    Unit = {
      Description = "Keep graphical-session.target active for portals";
      After = [ "graphical-session.target" ];
      BindsTo = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.coreutils}/bin/sleep infinity";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
