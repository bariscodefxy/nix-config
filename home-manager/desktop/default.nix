{ pkgs, lib, inputs, config, ... }:
{
  home.packages = with pkgs; [
    mako
    gnome-keyring
    kdePackages.polkit-kde-agent-1
    alacritty
    waybar
    apple-cursor
    wofi
    playerctl
    swaylock
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
    nautilus
    inputs.quickshell.packages.x86_64-linux.default
    swaybg
  ];
  
  home.file.".config/niri/" = {
    recursive = true;
    source = ./niri;
  };

  home.file.".config/waybar/" = {
    recursive = true;
    source = ./waybar;
  };

  home.file.".config/quickshell/" = {
    recursive = true;
    source = ./quickshell;
  };

  home.file.".config/swaybg/" = {
    recursive = true;
    source = ./swaybg;
  };

  stylix = {
    enable = true;
    autoEnable = true;

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 28;
    };

    fonts = {
     monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };

      sizes = {
        terminal = 14;
      };
    };

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-nord;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
  };
}
