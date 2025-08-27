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
        # I don't know why but, devsense extensions not available on unstable
        pkgs.stable.vscode-extensions.devsense.phptools-vscode
        pkgs.stable.vscode-extensions.devsense.composer-php-vscode
      ];
      userSettings = {
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = "true";
        "editor.formatOnSave" = "true";
        "editor.formatOnPaste" = "true";
      };
    };
  };
}
