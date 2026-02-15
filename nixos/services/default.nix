{ ... }:
{
  imports = [
    ./network
    ./desktop
    ./database
    ./hardware
  ];

  specialisation = {
    "singbox" = {
      inheritParentConfig = true;
      configuration =
        { config, pkgs, ... }:
        {
          system.nixos.tags = [ "singbox" ];
          imports = [
            ./network/singbox.nix
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
