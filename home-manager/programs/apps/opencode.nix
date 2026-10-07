{ ... }:
{
  # opencode (CLI + desktop aynı global config'i okur): GDrive mount'u
  # ajanlardan gizle. Kurallar "son eşleşen kazanır" çalışır.
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
  };

  # ripgrep tabanlı araçlar home altından tarama yaparsa GDrive'ı atlar.
  home.file.".ignore".text = "GDrive/\n";
}
