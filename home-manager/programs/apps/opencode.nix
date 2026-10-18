{ ... }:
{
  # force: `opencode2 plugin add` rewrote this as a regular file, so the
  # generated symlink cannot replace it and activation aborts with
  # "would be clobbered". The Nix-declared content is verified identical to
  # the on-disk file, so overwriting loses nothing.
  xdg.configFile."opencode/opencode.json".force = true;
  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    permission = {
      read = {
        "*" = "allow";
        "~/GDrive/**" = "deny";
      };
      edit = {
        "*" = "allow";
        "~/GDrive/**" = "deny";
      };
      glob = {
        "*" = "allow";
        "~/GDrive/**" = "deny";
      };
      grep = {
        "*" = "allow";
        "~/GDrive/**" = "deny";
      };
      bash = {
        "*" = "allow";
        "*GDrive*" = "deny";
      };
      external_directory = {
        "~/GDrive/**" = "deny";
      };
    };
    watcher = {
      ignore = [
        "GDrive/**"
        "~/GDrive/**"
      ];
    };
    mcp = {
      servers = {
        reactbits = {
          type = "local";
          command = [ "npx" "-y" "reactbits-dev-mcp-server" ];
          enabled = true;
        };
      };
    };
    # Installed via `opencode2 plugin add`, which replaced this generated
    # symlink with a regular file. Declaring it here makes the plugin survive
    # `home-manager switch`. The matching TUI entry lives in
    # ~/.config/opencode/cli.json, which home-manager does not manage.
    plugins = [ "@prevalentware/opencode-goal-plugin" ];
  };

  home.file.".ignore".text = "GDrive/\n";
}
