{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.system}.orca
    inputs.llm-agents.packages.${pkgs.system}.opencode2
    inputs.llm-agents.packages.${pkgs.system}.opencode2-desktop
  ];
}
