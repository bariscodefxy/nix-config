{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions =
      with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        ms-python.python
        ms-vscode.cpptools
        leonardssh.vscord
        devsense.phptools-vscode
        ms-python.python
        formulahendry.auto-rename-tag
        formulahendry.auto-close-tag
        ritwickdey.liveserver
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          publisher = "rifi2k";
          name = "format-html-in-php";
          version = "1.7.0";
          sha256 = "sha256-2o8bfCHygTLLzucoiq4h8DfgCKUlj0U7aV8vZr0XuDY=";
        }
        {
          publisher = "ms-vscode";
          name = "sublime-keybindings";
          version = "4.1.10";
          sha256 = "sha256-XlogenuBmP+tE18VLH4lUSpOq/7d022n8HgXnKjY3n0=";
        }
        {
          publisher = "ms-vscode";
          name = "vscode-typescript-next";
          version = "5.8.20250203";
          sha256 = "sha256-Q26s3GmCSg9AFbSOO83vEpXtYP2PQMFzpkeoJe5dDWE=";
        }
        {
          publisher = "mblode";
          name = "twig-language";
          version = "0.9.4";
          sha256 = "sha256-TZRjodIQkgFlPlMaZs3K8Rrcl9XCUaz4/vnIaxU+SSA=";
        }
        {
          publisher = "dracula-theme";
          name = "theme-dracula";
          version = "2.25.1";
          sha256 = "sha256-ijGbdiqbDQmZYVqZCx2X4W7KRNV3UDddWvz+9x/vfcA=";
        }
        {
          publisher = "GitHub";
          name = "copilot";
          version = "1.304.1522";
          sha256 = "sha256-lhkPvDNjoJGRh7Eu1U380X11L0RWyFCORWU8x7MK+Dk=";
        }
        {
          publisher = "GitHub";
          name = "copilot-chat";
          version = "0.27.2025042301";
          sha256 = "sha256-E4HM0TkUI5lbeW68974Sm5W/YGZ22p1OCmAW+r2gOBY=";
        }
      ];

    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "window.titleBarStyle" = "custom";

      "workbench.colorTheme" = "Dracula Theme";
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
      "editor.fontSize" = 18;
      "editor.fontLigatures" = true;
      "walTheme.autoUpdate" = true;

      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.formatOnPaste" = true;

      "editor.mouseWheelZoom" = true;

      "explorer.confirmDragAndDrop" = false;
      "editor.confirmDelete" = false;
      "git.confirmSync" = false;

      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
    };
  };
}
