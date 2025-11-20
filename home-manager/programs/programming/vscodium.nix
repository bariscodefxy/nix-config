{ pkgs, ... }:
{
  home.packages = with pkgs; [
    openssl
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscodium;
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
        github.copilot
        github.copilot-chat
        pkgs.unstable.vscode-extensions.danielsanmedium.dscodegpt
        svelte.svelte-vscode
      ];
      userSettings = {
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
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
