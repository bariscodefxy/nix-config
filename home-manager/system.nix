{ config, ... }:
{
  xdg.enable = true;
  xdg.systemDirs.data = [ "${config.xdg.dataHome}/nix-desktop-files" ];
#  xdg.configFile."mimeapps-list".force = true;
  

  home.activation.linkDesktopApplications = {
    after = [
      "writeBoundary"
      "createXdgUserDirectories"
    ];
    before = [ ];
    data = ''
      rm -rf ${config.xdg.dataHome}/nix-desktop-files/applications
      mkdir -p ${config.xdg.dataHome}/nix-desktop-files/applications
      cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/nix-desktop-files/applications/
    '';
  };
}
