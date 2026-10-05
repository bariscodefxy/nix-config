{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans 10";
    };
    iconTheme = {
      name = "MacTahoe-dark";
      package = pkgs.mactahoe-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
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
      gtk-theme = "Adwaita-dark";
    };
  };

  # Fallback for MacTahoe's Inherits=hicolor,breeze chain.
  home.packages = [ pkgs.kdePackages.breeze-icons ];
}
