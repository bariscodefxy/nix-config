{ ... }:
{
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
  };

  home.file.".ignore".text = "GDrive/\n";
}
