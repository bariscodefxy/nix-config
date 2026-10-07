{ config, lib, ... }:
{
  programs.rclone = {
    enable = true;
    remotes = {
      gdrive = {
        config = {
          type = "drive";
          scope = "drive";
        };
        secrets = {
          client_id = "${config.home.homeDirectory}/.config/rclone/secrets/gdrive-client-id";
          client_secret = "${config.home.homeDirectory}/.config/rclone/secrets/gdrive-client-secret";
          token = "${config.home.homeDirectory}/.config/rclone/secrets/gdrive-token";
        };
      };
      gcrypt = {
        config = {
          type = "crypt";
          remote = "gdrive:GizliDosyalar";
        };
        secrets = {
          password = "${config.home.homeDirectory}/.config/rclone/secrets/gcrypt-password";
          password2 = "${config.home.homeDirectory}/.config/rclone/secrets/gcrypt-password2";
        };
        mounts = {
          "" = {
            enable = true;
            mountPoint = "${config.home.homeDirectory}/GDrive";
            options = {
              dir-cache-time = "5000h";
              poll-interval = "30s";
            };
          };
        };
      };
    };
  };

  home.activation.createRcloneSecretsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p -m 700 ${config.home.homeDirectory}/.config/rclone/secrets
  '';
}
