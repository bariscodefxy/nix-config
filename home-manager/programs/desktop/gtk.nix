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

  # gtk modülü gtk.css üretmiyor (gtk3: sadece extraCss doluyken,
  # bu sürümde gtk4 için de tema importu yok). Eskiden elle yazılmış
  # koyu renkli gtk.css override'ları (örn. Gradience kalıntısı) temayı
  # eziyordu; bu dosyaları boş olarak sahiplen ki geri gelemesinler.
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
