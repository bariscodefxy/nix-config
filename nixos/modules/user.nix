{ pkgs, ... }:
{
  users.users = {
    bariscodefx = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "vboxusers"
        "libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };
}
