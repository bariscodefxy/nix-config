{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    autoEnable = true;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      zen-browser = {
        profileNames = [ "*" ];
      };
    };
  };

}
