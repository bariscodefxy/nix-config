{ ... }:
{
  users.users = {
    bariscodefx = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
    };
  };
}
