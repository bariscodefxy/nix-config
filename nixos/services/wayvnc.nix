{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.wayvnc;

  # noVNC's web root and the WebSocket proxy are two different packages.
  websockify = pkgs.python3Packages.websockify;
  novncWebRoot = "${pkgs.novnc}/share/webapps/novnc";
in
{
  options.services.wayvnc = {
    enable = lib.mkEnableOption "exposes the live Wayland session to a browser over VNC (wayvnc + noVNC)";

    output = lib.mkOption {
      type = lib.types.str;
      default = "eDP-1";
      description = ''
        Name of the output to capture. The internal panel is exposed by niri
        as "eDP-1" on this machine. See the full list with `niri msg outputs`;
        wayvnc exits with "No such output" if the name does not match.
      '';
    };

    novncPort = lib.mkOption {
      type = lib.types.port;
      default = 6080;
      description = "Port noVNC (web client + WebSocket proxy) listens on.";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Open the port in the firewall. Disable to restrict access to tailscale0 only.";
    };

    renderCursor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Draw the mouse cursor server-side. Disable and the cursor is invisible in the browser.";
    };

    keyboardLayout = lib.mkOption {
      type = lib.types.str;
      default = "tr";
      description = ''
        XKB layout wayvnc uses to translate incoming keys into key codes.

        A browser sends keysyms (logical keys), not physical key codes, so
        wayvnc must pick a layout for the reverse lookup. Without this it
        assumes US, which makes VNC typing come out as English while the
        physical keyboard produces Turkish characters.

        This is INDEPENDENT of niri's `layout "tr,us"` setting: the
        physical keyboard is resolved by niri/XKB, VNC input by wayvnc.
        They do not have to match, but it is less confusing if they do.
      '';
    };
  };

  config = {
    # Requested for this machine: both hosts are the same physical device,
    # and wayvnc reflects whichever session is currently running. Disable
    # with `services.wayvnc.enable = false;` elsewhere.
    services.wayvnc.enable = lib.mkDefault true;

    networking.firewall.allowedTCPPorts =
      lib.mkIf (cfg.enable && cfg.openFirewall) [ cfg.novncPort ];

    # ------------------------------------------------------------------
    # 1) wayvnc — inside the session, as a systemd.user service
    #
    # This is NOT a separate desktop. wayvnc mirrors the screen of the
    # Wayland session it attaches to; whatever is on the physical display
    # is what the browser sees. There is no extra X server, no window
    # manager and no session script.
    #
    # It has to be a user service: the compositor's Wayland socket is only
    # reachable from inside the session, a system service cannot get to it.
    # ------------------------------------------------------------------
    systemd.user.services.wayvnc = lib.mkIf cfg.enable {
      description = "wayvnc — serves the live Wayland session over VNC";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      environment.PATH = lib.mkForce null;

      serviceConfig = {
        # NOTE: the ExecStart list must have exactly ONE element. NixOS
        # writes each element as its own "ExecStart=" line, which systemd
        # only accepts for Type=oneshot ("Service has more than one
        # ExecStart= setting ... Refusing").
        ExecStart = [
          (lib.concatStringsSep " " (
            [
              "${pkgs.wayvnc}/bin/wayvnc"
              "-o"
              cfg.output
              # A browser sends keysyms, not key codes. This value decides
              # which physical key a keysym maps to; without it wayvnc
              # assumes US and VNC typing comes out as English.
              "-k"
              cfg.keyboardLayout
            ]
            ++ lib.optionals cfg.renderCursor [ "-r" ]
          ))
        ];
        # "always", not "on-failure": the session restarts (niri restarting,
        # for instance) should bring VNC back. "on-failure" does not fire
        # on a clean exit.
        Restart = "always";
        RestartSec = "2s";
      };
    };

    # ------------------------------------------------------------------
    # 2) noVNC — the browser bridge, as a system service
    #
    # NOTE: do NOT use pkgs.novnc's `bin/novnc` bash wrapper. Line 213
    # verifies websockify with `ps -eo pid=`; procps (ps) is not in the
    # systemd PATH, so the wrapper exits 1 and the service crash-loops
    # (measured: NRestarts=147). websockify's own --web/--file-only/
    # --heartbeat options do the same job.
    # ------------------------------------------------------------------
    systemd.services.novnc = lib.mkIf cfg.enable {
      description = "noVNC web client + WebSocket proxy -> wayvnc";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        ExecStart = [
          (lib.concatStringsSep " " [
            "${websockify}/bin/websockify"
            "--web"
            novncWebRoot
            "--file-only"
            "--heartbeat"
            "30"
            "0.0.0.0:${toString cfg.novncPort}"
            # wayvnc listens on localhost by default.
            "127.0.0.1:5900"
          ])
        ];
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };

    # ------------------------------------------------------------------
    # Browser URL (LAN):
    #
    #   http://<host>:6080/vnc.html?host=<host>&port=6080&autoconnect=1
    #
    # Verify:
    #
    #   systemctl --user status wayvnc      # inside the session
    #   systemctl status novnc
    #   ss -ltn | grep -E '5900|6080'     # 5900 must be 127.0.0.1 only
    #
    # SECURITY: there is no password. Anyone on the LAN can connect to
    # 6080 and both view and control the session. To lock it down set
    # openFirewall = false (tailscale0 only).
    # ------------------------------------------------------------------
  };
}
