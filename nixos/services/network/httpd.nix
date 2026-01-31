{ pkgs, lib, ... }:
{
  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "admin@email.tld";

    extraConfig = ''
      DirectoryIndex index.html index.php
    '';

    virtualHosts =
      let
        configFile = pkgs.writeText "config.inc.php" ''
          <?php
          //$cfg['Servers'][1]['auth_type'] = 'http';
          /* Server parameters */
          $cfg['Servers'][1]['host'] = 'localhost';
          $cfg['Servers'][1]['compress'] = false;
          $cfg['Servers'][1]['AllowNoPassword'] = false;
        '';
        phpmyadminPkg = pkgs.phpmyadmin.override { inherit configFile; };
      in
      {
        phpmyadmin = {
          hostName = "phpmyadmin.tld";
          documentRoot = phpmyadminPkg;
          extraConfig = ''
            <Directory "${phpmyadminPkg}">
              Options -Indexes
              AllowOverride None
              Require all granted
            </Directory>
          '';
        };
      };
  };
}
