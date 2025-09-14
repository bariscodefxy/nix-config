{ pkgs, ... }:
{
  users.users = {
    bariscodefx = {
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
