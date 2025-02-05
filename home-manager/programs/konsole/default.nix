{ ... }:
{
  programs.konsole = {
    enable = true;

    defaultProfile = "konsoleProfile";
    profiles = {
      "konsoleProfile" = {
      };
    };
  };
}
