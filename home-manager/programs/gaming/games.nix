{
  inputs,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    inputs.prismlauncher.packages.${system}.prismlauncher

    # Minecraft Bedrock (the Windows build) through Wine, with real Xbox
    # sign-in. Upstream only builds it for x86_64-linux.
    inputs.bedrock-on-linux.packages.${system}.default
  ];
}
