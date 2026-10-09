{ pkgs, ... }:
{
  # Theme (gtk-theme, icon-theme, dark preference) is NOT managed here:
  # the shell owns it at runtime via System Settings → Appearance.
  # Only font and cursor stay declarative.
  gtk = {
    enable = true;
    font = {
      name = "SF Pro Display 10";
    };
  };

  # Theme FILES only, no selection: the shell picks WhiteSur-Dark/Light at
  # runtime via System Settings → Appearance (settings.ini + dconf).
  home.packages = [
    pkgs.whitesur-gtk-theme
    pkgs.whitesur-icon-theme
    pkgs.kdePackages.breeze-icons
  ];

  # The gtk module does not generate gtk.css (gtk3: only when extraCss is set,
  # and this version lacks theme import for gtk4). Previously manually written
  # dark gtk.css overrides (e.g. leftover Gradience) overwrote the theme;
  # claim these files as empty so they cannot come back.
  xdg.configFile = {
    "gtk-3.0/gtk.css" = {
      text = "";
      force = true;
    };
    "gtk-4.0/gtk.css" = {
      text = "";
      force = true;
    };
  };
}
