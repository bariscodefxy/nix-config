{ pkgs, ... }:
{
  environment.systemPackages =
    let
      php = pkgs.php.buildEnv { extraConfig = "memory_limit = 2G"; };
    in
    [
      php
      pkgs.php84Packages.composer
    ];
}
