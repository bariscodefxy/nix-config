{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "ls -l";
      resystem = "sudo nixos-rebuild switch --flake .#victus";
      rehome = "home-manager switch --flake .#bariscodefx@victus";
    };

    autocd = true;
  };
}
