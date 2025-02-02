{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "bariscodefx";
    userEmail = "root@bariscodefx.com.tr";
    extraConfig = {
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    };
  };
}
