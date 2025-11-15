{ pkgs, ... }:
{
  home.packages = with pkgs; [
    openssl
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
        oops418.nix-env-picker
        leonardssh.vscord
        ziglang.vscode-zig
        devsense.phptools-vscode
        devsense.composer-php-vscode
        rooveterinaryinc.roo-cline
      ];
      userSettings = {
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
        "git.confirmSync" = false;
        "git.autofetch" = true;
      };
    };
  };
}
