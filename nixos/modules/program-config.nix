{ ... }:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
}
