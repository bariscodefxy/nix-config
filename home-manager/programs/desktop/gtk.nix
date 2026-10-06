{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "SF Pro Display 10";
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "WhiteSur-Dark";
    };
  };

  # Fallback for WhiteSur-dark's Inherits=hicolor,breeze chain.
  home.packages = [ pkgs.kdePackages.breeze-icons ];

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
