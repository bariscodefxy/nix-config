{ ... }:
{
  programs.git = {
    enable = true;
    userName = "bariscodefx";
    userEmail = "root@bariscodefx.tr";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
