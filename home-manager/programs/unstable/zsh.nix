{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;

    shellAliases = {
      ll = "ls -l";
      resystem = "sudo nixos-rebuild switch --flake .#victus";
      rehome = "home-manager switch --flake .#bariscodefx@victus";
      neofetch = "fastfetch";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "direnv"
      ];
    };
  };
}
