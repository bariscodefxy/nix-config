{ ... }:
{
  imports = [
    ./flatpak.nix
    ./mariadb.nix
    ./mullvad.nix
    #./nginx.nix
    ./openssh.nix
    ./pipewire.nix
    ./squid.nix
    ./victus-control/default.nix
    ./xscreensaver.nix
  ];

  specialisation = {
    "singbox" = {
      inheritParentConfig = true;
      configuration =
        { config, pkgs, ... }:
        {
          system.nixos.tags = [ "singbox" ];
          imports = [
            ./singbox.nix
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
            ./dnscrypt.nix
            ./zapret.nix
          ];
        };
    };
  };
}
