{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

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

    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source $HOME/.p10k.zsh
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "direnv"
      ];
    };
  };
}
