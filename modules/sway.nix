{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.sessionVariables = {
    # WLR_RENDERER = "vulkan";
  };

  home.packages = with pkgs; [
    vulkan-validation-layers
  ];

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 15000;
    };
  };

  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      ring-color = "21ffe9";
      key-hl-color = "880033";
      line-color = "00000000";
      inside-color = "00000088";
      separator-color = "00000000";
      # grace = 2;
      fade-in = 3;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    checkConfig = false;
    extraConfig = ''
      workspace 1 output eDP-1
      workspace 2 output eDP-1
      workspace 3 output eDP-1
      workspace 4 output eDP-1
      workspace 5 output eDP-1
      workspace 6 output eDP-1
      workspace 7 output eDP-1
      workspace 8 output eDP-1
      workspace 9 output eDP-1
      workspace 10 output eDP-1
      workspace -1 output DP-1
      workspace -2 output DP-1
      workspace -3 output DP-1
      workspace -4 output DP-1
      workspace -5 output DP-1
      workspace -6 output DP-1
      workspace -7 output DP-1
      workspace -8 output DP-1
      workspace -9 output DP-1
      workspace -10 output DP-1
      workspace ^1 output HDMI-A-1
      workspace ^2 output HDMI-A-1
      workspace ^3 output HDMI-A-1
      workspace ^4 output HDMI-A-1
      workspace ^5 output HDMI-A-1
      workspace ^6 output HDMI-A-1
      workspace ^7 output HDMI-A-1
      workspace ^8 output HDMI-A-1
      workspace ^9 output HDMI-A-1
      workspace ^10 output HDMI-A-1

      exec wl-paste -t text --watch clipman store

      set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
      exec rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob

      exec swayidle \
          before-sleep swaylock
          # timeout 300 "swaylock -f" \
          # timeout 330 "swaymsg 'output * power off'" \
          # resume "swaymsg 'output * power on'" \

      # Brightness
      bindsym XF86MonBrightnessDown exec "brightnessctl set 2%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK"
      bindsym XF86MonBrightnessUp exec "brightnessctl set +2% | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK"

      # Volume
      bindsym XF86AudioRaiseVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ -l 1 && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -e "/MUTED/I c0" -e "s/[^[:digit:]]//g" > $WOBSOCK'
      bindsym XF86AudioLowerVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- -l 1 && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -e "/MUTED/I c0" -e "s/[^[:digit:]]//g" > $WOBSOCK'
      bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -e "/MUTED/I c0" -e "s/[^[:digit:]]//g" > $WOBSOCK'

      # for_window [title="^\.zoom $"] {
      #   floating enable
      #   sticky enable
      # }

      for_window [app_id="code"] {
        opacity 0.85
        # opacity 1
      }

      focus output eDP-1
    '';
    config =
      let
        mouse = "1390:307:DEFT_Pro_TrackBall";
        hhkb = "1278:33:PFU_Limited_HHKB-Hybrid";
        laptop-kb = "1:1:AT_Translated_Set_2_keyboard";
      in
      rec {
        bars = [ ];
        startup = [
          {
            command = "systemctl --user restart waybar";
            always = true;
          }
          # { command = "sudo python ${../etc/wayremap.config.py}"; }
          # { command = "vivaldi"; }
        ];
        gaps = {
          inner = 15;
          smartGaps = true;
        };
        # terminal = "alacritty";
        terminal = "kitty";
        menu = "wofi -S run";
        modifier = "Mod4";
        input = {
          "4660:22136:xremap" = {
            xkb_layout = "jp";
          };
          ${laptop-kb} = {
            xkb_layout = "jp";
          };
          "*" = {
            drag = "disabled";
            xkb_options = "ctrl:nocaps";
          };
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
            scroll_factor = "0.5";
          };
          ${hhkb} = {
            xkb_model = "hhk";
            xkb_layout = "us";
          };
        };
        output = {
          "*" = {
            background = "~/Pictures/wallpapers/coneru.png fill";
          };
          "DP-1" = {
            position = "0 0";
          };
          "eDP-1" = {
            position = "3840 0";
          };
          "HDMI-A-1" = {
            position = "3840 520";
          };
        };
        keybindings = lib.mkOptionDefault (
          {
            "${modifier}+p" = "exec grimshot copy output --notify";
            "${modifier}+Shift+p" = "exec grimshot copy area --notify";
            "${modifier}+Shift+v" = "exec clipman pick -t wofi";
            "XF86AudioPlay" = "exec playerctl play-pause";
            "XF86AudioPrev" = "exec playerctl position 5-";
            "XF86AudioNext" = "exec playerctl position 5+";
            "Ctrl+XF86AudioPrev" = "exec playerctl previous";
            "Ctrl+XF86AudioNext" = "exec playerctl next";
            "--input-device=${mouse} --whole-window BTN_FORWARD" = "exec echo";
            "--input-device=${mouse} --whole-window BTN_BACK" = "exec echo";
            "--input-device=${mouse} --whole-window BTN_TASK" = "exec echo";

            "${modifier}+Ctrl+l" = "exec swaylock";
          }
          // lib.mergeAttrsList (
            map (
              n':
              let
                n = toString n';
              in
              {
                "${modifier}+Ctrl+${n}" = "workspace -${n}";
                "${modifier}+Ctrl+Shift+${n}" = "move container to workspace -${n}";
                "${modifier}+Alt+${n}" = "workspace ^${n}";
                "${modifier}+Alt+Shift+${n}" = "move container to workspace ^${n}";
              }
            ) (lib.range 1 9)
          )
        );
      };
  };
}
