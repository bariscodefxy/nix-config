{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #zsh-powerlevel10k
    zsh-autosuggestions
    zsh-history-substring-search
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;

    shellAliases = {
      ll = "ls -l";
      neofetch = "fastfetch";
      push-oag = "git push ; git push github master";
    };

    initContent = ''
      #source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      #source $HOME/.p10k.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    '';

    oh-my-zsh = {
      enable = true;
      theme = "minimal";
      plugins = [
        "direnv"
        "git"
      ];
    };
  };
}
