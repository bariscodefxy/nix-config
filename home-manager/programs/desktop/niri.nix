{ pkgs, ... }:
{
  xdg.configFile."niri/config.kdl" = {
    text = ''
      input {
        keyboard {
          xkb {
            layout "tr,us"
            options "grp:caps_toggle"
          }
        }

        touchpad {
          natural-scroll
        }

        focus-follows-mouse max-scroll-amount="0%"
      }

      layout {
        gaps 5
        struts {
          left 5
          right 5
          top 5
          bottom 5
        }

        focus-ring {
          off
        }

        border {
          off
        }

        shadow {
          on
          softness 30
          spread 5
          offset x=0 y=5
          draw-behind-window true
          color "#00000070"
        }
      }

      prefer-no-csd

      window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
      }

      spawn-at-startup "qs"
      spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

      blur {
        passes 2
        offset 1.5
      }

      binds {
        Mod+B { spawn "chromium"; }
        Mod+E { spawn "${pkgs.thunar}/bin/thunar"; }
        Mod+Q { spawn "${pkgs.alacritty}/bin/alacritty"; }
        Mod+Space { spawn-sh "quickshell ipc call launcher spotlight"; }
        Mod+C repeat=false { close-window; }
        Mod+M { quit skip-confirmation=true; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+V { toggle-window-floating; }
        Mod+P { consume-window-into-column; }
        Mod+J { expel-window-from-column; }
        Mod+L { spawn "swaylock"; }

        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up { focus-window-up; }
        Mod+Down { focus-window-down; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Shift+1 { move-window-to-workspace 1; }
        Mod+Shift+2 { move-window-to-workspace 2; }
        Mod+Shift+3 { move-window-to-workspace 3; }
        Mod+Shift+4 { move-window-to-workspace 4; }
        Mod+Shift+5 { move-window-to-workspace 5; }
        Mod+Shift+6 { move-window-to-workspace 6; }
        Mod+Shift+7 { move-window-to-workspace 7; }
        Mod+Shift+8 { move-window-to-workspace 8; }
        Mod+Shift+9 { move-window-to-workspace 9; }
        Mod+Shift+0 { move-window-to-workspace 10; }

        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }

        Print { spawn-sh "grim -g \"$(slurp)\" - | swappy -f -"; }
        Shift+Print { spawn-sh "grim - | swappy -f -"; }
        Mod+Print { spawn-sh "grim -g \"$(slurp)\" - | wl-copy"; }

        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "5%+"; }

        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; }
        XF86AudioMute allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

        XF86AudioPlay allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "play-pause"; }
        XF86AudioPause allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "play-pause"; }
        XF86AudioNext allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "next"; }
        XF86AudioPrev allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "previous"; }
        XF86AudioStop allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "stop"; }
      }
    '';
  };
}
