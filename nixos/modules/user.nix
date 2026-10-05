{ pkgs, ... }:
{
  users.users = {
    baris = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "victus"
      ];
      shell = pkgs.zsh;
    };
  };
}
