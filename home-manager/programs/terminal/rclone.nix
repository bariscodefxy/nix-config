{ config, lib, ... }:
{
  programs.rclone = {
    enable = true;
    remotes = {
      drive = {
        config = {
          type = "drive";
        };
        secrets = {
          # OAuth token JSON (rclone authorize çıktısı), 600 izinli dosya.
          token = "${config.home.homeDirectory}/.config/rclone/secrets/drive-token";
        };
      };
      encrypted = {
        config = {
          type = "crypt";
          remote = "drive:/encrypted";
          filename_encryption = "standard";
          directory_name_encryption = true;
        };
        secrets = {
          # Crypt parolası (düz metin, rclone enjeksiyonda obscure eder).
          password = "${config.home.homeDirectory}/.config/rclone/secrets/crypt-password";
        };
      };
    };
  };

  # Secret dosyaları için 700 izinli dizin (içi kullanıcı tarafından doldurulur).
  home.activation.createRcloneSecretsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p -m 700 ${config.home.homeDirectory}/.config/rclone/secrets
  '';
}
