{
  pkgs,
  lib,
  config,
  ...
}:
{
  # 1. Enable PHP-FPM (Nginx needs this to process PHP)
  services.phpfpm.pools.phpmyadmin = {
    user = "nginx";
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
    };
  };

  # 2. Enable Nginx
  services.nginx = {
    enable = true;

    virtualHosts =
      let
        configFile = pkgs.writeText "config.inc.php" ''
          <?php
          $cfg['Servers'][1]['host'] = 'localhost';
          $cfg['Servers'][1]['compress'] = false;
          $cfg['Servers'][1]['AllowNoPassword'] = false;
        '';
        phpmyadminPkg = pkgs.phpmyadmin.override { inherit configFile; };
      in
      {
        "phpmyadmin.tld" = {
          # Point to the phpMyAdmin package
          root = "${phpmyadminPkg}";

          # Handle index files
          locations."/" = {
            index = "index.php index.html";
          };

          # Pass PHP scripts to PHP-FPM
          locations."~ \\.php$" = {
            extraConfig = ''
              fastcgi_pass unix:${config.services.phpfpm.pools.phpmyadmin.socket};
              fastcgi_index index.php;
              include ${pkgs.nginx}/conf/fastcgi_params;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            '';
          };
        };
      };
  };
}
