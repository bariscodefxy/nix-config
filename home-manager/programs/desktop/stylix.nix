{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    autoEnable = true;
    enable = true;
    polarity = "dark";
    targets = {
      zen-browser = {
        profileNames = [ "*" ];
      };
    };
  };

}
