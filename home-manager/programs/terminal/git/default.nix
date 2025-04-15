{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "bariscodefx";
    userEmail = "root@bariscodefx.tr";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
