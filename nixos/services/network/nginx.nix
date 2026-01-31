{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedOptimisation = true;

    virtualHosts = {
      "localhost" = {
        root = pkgs.phpmyadmin;

        locations = {
          "/" = {
            index = "index.php index.html index.htm";
          };

          "~ \\.php$" = {
            extraConfig = ''
              fastcgi_pass unix:${config.services.phpfpm.pools.phpmyadmin.socket};
              fastcgi_index index.php;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
              include ${pkgs.nginx}/conf/fastcgi_params;
            '';
          };
        };
      };
    };
  };

  services.phpfpm = {
    phpPackage = pkgs.php84;

    pools = {
      phpmyadmin = {
        user = "nginx";
        group = "nginx";
        settings = {
          "pm" = "dynamic";
          "pm.max_children" = 5;
          "pm.start_servers" = 2;
          "pm.min_spare_servers" = 1;
          "pm.max_spare_servers" = 3;
          "listen.owner" = "nginx";
          "listen.group" = "nginx";
          "listen.mode" = "0660";
        };
      };
    };
  };

  systemd.services.phpfpm-phpmyadmin.serviceConfig.ProtectHome = lib.mkForce false;

  systemd.services.nginx.serviceConfig.ProtectHome = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    phpmyadmin
  ];
}
