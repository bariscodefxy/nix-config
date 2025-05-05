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
        "kvm"
      ];
      shell = pkgs.zsh;
    };
  };
}
