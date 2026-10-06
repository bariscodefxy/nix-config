{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      credential.helper = "store";
      http = {
        postBuffer = 157286400;
      };
      https = {
        postBuffer = 157286400;
      };
      user = {
        name = "baris";
        email = "baris@bariscodefx.tr";
        signingkey = "43FEAB6CBC471F07";
      };
      commit = {
        gpgsign = true;
      };
    };
  };
}
