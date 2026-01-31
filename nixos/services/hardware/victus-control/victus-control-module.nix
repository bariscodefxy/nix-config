{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.victus-control;
  victus-control = pkgs.victus-control;
in
{
  options.services.victus-control = {
    enable = lib.mkEnableOption "Victus Control backend service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ victus-control ];

    systemd.services.victus-backend = {
      description = "Victus Control Backend Service";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${victus-control}/bin/victus-backend";
        Restart = "on-failure";
      };
    };
  };
}
