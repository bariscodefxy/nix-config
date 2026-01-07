{ ... }:
{
  imports = [
    ./flatpak.nix
    ./mariadb.nix
    ./mullvad.nix
    ./openssh.nix
    ./pipewire.nix
    ./xscreensaver.nix
  ];

  specialisation = {
    "redsocks" = {
      inheritParentConfig = true;
      configuration =
        { config, pkgs, ... }:
        {
          system.nixos.tags = [ "redsocks" ];
          imports = [
            ./redsocks.nix
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
