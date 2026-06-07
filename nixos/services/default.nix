{ ... }:
{
  imports = [
    ./network
    ./desktop
    ./database
    ./hardware
  ];

  specialisation = {
    "xray-tproxy" = {
      inheritParentConfig = true;
      configuration =
        { config, pkgs, ... }:
        {
          system.nixos.tags = [ "xray-tproxy" ];
          imports = [
            ./network/xray-tproxy.nix
          ];
        };
    };
    "zapret" = {
      inheritParentConfig = true;
      configuration =
        { config, pkgs, ... }:
        {
          system.nixos.tags = [ "zapret" ];
          imports = [
            ./network/dnscrypt.nix
            ./network/zapret.nix
          ];
        };
    };
  };
}
