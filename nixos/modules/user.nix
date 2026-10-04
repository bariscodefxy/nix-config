{ pkgs, ... }:
{
  users.users = {
    baris = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };
  };
}
