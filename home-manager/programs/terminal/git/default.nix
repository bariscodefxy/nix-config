{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "bariscodefx";
    userEmail = "root@bariscodefx.tr";
    extraConfig = {
      credential.helper = "store";
      http = {
        postBuffer = 157286400;
      };
      https = {
        postBuffer = 157286400;
      };
    };
  };
}
