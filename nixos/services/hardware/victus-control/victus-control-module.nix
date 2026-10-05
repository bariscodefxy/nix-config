{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.victus-control;
  pkg = pkgs.victus-control;
in
{
  options.services.victus-control = {
    enable = lib.mkEnableOption "Victus Control backend service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkg ];

    users.groups.victus = { };
    users.groups.victus-backend = { };
    users.users.victus-backend = {
      isSystemUser = true;
      group = "victus-backend";
      extraGroups = [ "victus" ];
      description = "Victus Control backend service user";
    };

    services.udev.packages = [ pkg ];

    systemd.tmpfiles.rules = [
      "d /run/victus-control 0770 victus-backend victus - -"
    ];

    security.sudo.extraRules = [
      {
        users = [ "victus-backend" ];
        commands = map (h: {
          command = "${pkg}/bin/${h}";
          options = [ "NOPASSWD" ];
        }) [
          "set-fan-speed.sh"
          "set-fan-mode.sh"
          "set-rgb-zone.sh"
          "set-rgb-zones.sh"
        ];
      }
    ];

    systemd.services.victus-healthcheck = {
      description = "Victus Control kernel module health check";
      wantedBy = [ "multi-user.target" ];
      before = [ "victus-backend.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkg}/lib/victus-control/victus-healthcheck.sh";
        RemainAfterExit = true;
      };
    };

    systemd.services.victus-backend = {
      description = "Victus Control Backend Service";
      wantedBy = [ "multi-user.target" ];
      after = [
        "network.target"
        "victus-healthcheck.service"
        "systemd-udev-settle.service"
      ];
      wants = [ "victus-healthcheck.service" ];
      conflicts = [ "victus-fan.service" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkg}/bin/victus-backend";
        Restart = "always";
        RestartSec = 5;
        User = "victus-backend";
        Group = "victus";
        StateDirectory = "victus-control";
        RuntimeDirectory = "victus-control";
        RuntimeDirectoryMode = "0770";
      };
    };
  };
}
