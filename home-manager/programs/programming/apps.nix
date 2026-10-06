{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cudatext
  ];
}
