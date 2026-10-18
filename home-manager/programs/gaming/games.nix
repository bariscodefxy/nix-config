{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
  ];
}
