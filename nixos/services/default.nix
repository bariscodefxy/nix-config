{ ... }:
{
  imports = [
    ./flatpak.nix
    ./mullvad.nix
    ./openssh.nix
    ./pipewire.nix
    ./xscreensaver.nix
  ];

  specialisation = {
    "redsocks" = {
      inheritParentConfig = true;
      configuration = { config, pkgs, ... }: {
        system.nixos.tags = [ "spec-redsocks" ];
        imports = [
          ./redsocks.nix
        ];
      };
    };
    "zapret" = {
      inheritParentConfig = true;
      configuration = { config, pkgs, ... }: {
        system.nixos.tags = [ "spec-zapret" ];
        imports = [
          ./dnscrypt.nix
          ./zapret.nix
        ];
      };
    };
  };
}
