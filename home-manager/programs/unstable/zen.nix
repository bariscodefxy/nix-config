{ inputs, pkgs, ... }:
{
  home.packages = with inputs; [
    zen-browser.packages."${pkgs.system}".default
  ];
}
