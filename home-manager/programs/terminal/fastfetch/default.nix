{
  pkgs,
  lib,
  ...
}:
{
  home.file.".config/fastfetch/fastfetch.png" = {
    source = ./logo.png;
  };

  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "$HOME/.config/fastfetch/fastfetch.png";
        width = 25;
        padding = {
          top = 2;
          left = 4;
        };
      };
      display = {
        percent = {
          type = 9;
        };
        separator = " 󰁔 ";
      };
      modules =
        [
          {
            type = "custom";
            format = ''┌──────────── OS Information ────────────┐'';
          }
          {
            type = "title";
            key = " ╭─ ";
          }
        ]
        ++ lib.optionals pkgs.stdenv.isDarwin [
          {
            type = "os";
            key = " ├─  ";
          }
          {
            type = "kernel";
            key = " ├─  ";
          }
          {
            type = "packages";
            key = " ├─  ";
          }
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          {
            type = "os";
            key = " ├─ ";
          }
          {
            type = "kernel";
            key = " ├─ ";
          }
          {
            type = "packages";
            key = " ├─ ";
          }
        ]
        ++ [
          {
            type = "shell";
            key = " ╰─  ";
          }
          {
            type = "custom";
            format = ''├───────── Hardware Information ─────────┤'';
          }
          {
            type = "display";
            key = " ╭─ 󰍹 ";
            compactType = "original-with-refresh-rate";
          }
          {
            type = "cpu";
            key = " ├─ 󰍛 ";
          }
          {
            type = "gpu";
            key = " ├─  ";
          }
          {
            type = "disk";
            key = " ├─ 󱛟 ";
          }
          {
            type = "memory";
            key = " ╰─  ";
          }
          {
            type = "custom";
            format = ''├───────── Software Information ─────────┤'';
          }
          {
            type = "wm";
            key = " ╭─  ";
          }
          {
            type = "terminal";
            key = " ├─  ";
          }
          {
            type = "font";
            key = " ╰─  ";
          }
          {
            type = "custom";
            format = ''└────────────────────────────────────────┘'';
          }
          {
            type = "custom";
            format = "   {#39}   {#34}    {#36}    {#35}    {#34}    {#33}    {#32}    {#31} ";
          }
          "break"
        ];
    };
  };
}
