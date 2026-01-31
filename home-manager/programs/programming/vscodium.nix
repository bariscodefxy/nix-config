{ pkgs, ... }:
{
  home.packages = with pkgs; [
    openssl
  ];

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        bbenoist.nix
        jnoortheen.nix-ide
        io-github-oops418.nix-env-picker
        leonardssh.vscord
        ziglang.vscode-zig
        devsense.phptools-vscode
        devsense.composer-php-vscode
        rooveterinaryinc.roo-cline
        svelte.svelte-vscode
        aswinkumar863.smarty-template-support
      ];
      userSettings = {
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
        "git.confirmSync" = false;
        "git.autofetch" = true;
        "explorer.confirmDelete" = false;
        "roo-cline.allowedCommands" = [
          "git log"
          "git diff"
          "git show"
        ];
        "roo-cline.deniedCommands" = [ ];
      };
    };
  };
}
