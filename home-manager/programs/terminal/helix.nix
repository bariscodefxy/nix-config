{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        indent-guides.render = true;
        soft-wrap.enable = true;
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
          language-servers = [ "nixd" ];
        }
        {
          name = "php";
          language-servers = [ "phpactor" ];
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = [ "svelte-language-server" ];
        }
        {
          name = "zig";
          auto-format = true;
          language-servers = [ "zls" ];
        }
      ];
    };

    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
      phpactor
      svelte-language-server
      prettier
      zls
      zig
    ];
  };
}
