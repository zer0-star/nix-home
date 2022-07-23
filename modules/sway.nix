{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    extraConfig = ''
      exec wl-paste -t text --watch clipman store

      set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
      exec rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob

      # Brightness
      bindsym XF86MonBrightnessDown exec "brightnessctl set 2%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK"
      bindsym XF86MonBrightnessUp exec "brightnessctl set +2% | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK"

      # Volume
      bindsym XF86AudioRaiseVolume exec 'pamixer -i 1 && pamixer --get-volume > $WOBSOCK'
      bindsym XF86AudioLowerVolume exec 'pamixer -d 1 && pamixer --get-volume > $WOBSOCK'
      bindsym XF86AudioMute exec 'pamixer -t && ( pamixer --get-mute && echo 0 > $WOBSOCK ) || pamixer --get-volume > $WOBSOCK'

      # for_window [title="^\.zoom $"] {
      #   floating enable
      #   sticky enable
      # }
    '';
    config = let
      mouse = "1390:307:DEFT_Pro_TrackBall";
    in rec {
      bars = [ ];
      startup =[
        { command = "systemctl --user restart waybar"; always = true; }
        # { command = "vivaldi"; }
      ];
      terminal = "alacritty";
      menu = "wofi -S run";
      modifier = "Mod4";
      input = {
        "*" = {
          xkb_layout = "jp";
          xkb_options = "ctrl:nocaps";
          drag = "disabled";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.5";
        };
      };
      output."*" = {
        background = "~/Pictures/wallpapers/coneru.png fill";
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+Ctrl+3" = "exec grimshot copy screen --notify";
        "${modifier}+v" = "exec clipman pick -t wofi";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioNext" = "exec playerctl next";
        "--input-device=${mouse} --whole-window BTN_FORWARD" = "exec echo";
        "--input-device=${mouse} --whole-window BTN_BACK" = "exec echo";
        "--input-device=${mouse} --whole-window BTN_TASK" = "exec echo";
      };
    };
  };
}
