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
          # Git'e düşmemesi için kimlik bilgileri dosyadan enjekte ediliyor.
          client_id = "${config.home.homeDirectory}/.config/rclone/secrets/gdrive-client-id";
          client_secret = "${config.home.homeDirectory}/.config/rclone/secrets/gdrive-client-secret";
          # OAuth token JSON (rclone authorize çıktısı).
          token = "${config.home.homeDirectory}/.config/rclone/secrets/gdrive-token";
        };
      };
      gcrypt = {
        config = {
          type = "crypt";
          remote = "gdrive:GizliDosyalar";
        };
        secrets = {
          # Crypt parolaları (düz metin, rclone enjeksiyonda obscure eder).
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

  # Secret dosyaları için 700 izinli dizin (içi kullanıcı tarafından doldurulur).
  home.activation.createRcloneSecretsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p -m 700 ${config.home.homeDirectory}/.config/rclone/secrets
  '';
}
