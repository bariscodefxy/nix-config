{ ... }:
{
  programs.git = {
    enable = true;
    userName = "bariscodefx";
    userEmail = "root@bariscodefx.com.tr";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
