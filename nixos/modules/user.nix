{ pkgs, ... }:
{
  users.users = {
    bariscodefx = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "libvirtd"
        "kvm"
      ];
      shell = pkgs.zsh;
    };
  };
  users.extraGroups.docker.members = [ "bariscodefx" ];
  users.extraGroups.libvirtd.members = [ "bariscodefx" ];
}
