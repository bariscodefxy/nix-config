{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.orca
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.antigravity-cli
  ];
}
