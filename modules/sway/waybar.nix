{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      main = {
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
          ];
        };
        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% 󰂄";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-plugged = "{capacity}% ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        "battery#bat2" = {
          bat = "BAT2";
        };
        clock = {
          format = "{:%H:%M:%S}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 1;
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        "custom/launcher" = {
          format = " ";
          on-click = "rofi -show drun -theme ~/.config/rofi/sway/sway_config.rasi";
          on-click-right = "killall rofi";
        };
        "custom/media" = {
          escape = true;
          # exec = "$HOME/.config/system_scripts/mediaplayer.py 2> /dev/null";
          exec = "${pkgs.waybar-mpris}/bin/waybar-mpris --position --autofocus --pause 󰏤 --order SYMBOL:ARTIST:TITLE:POSITION";
          on-click = "${pkgs.waybar-mpris}/bin/waybar-mpris --send toggle";
          format = "{icon} {}";
          format-icons = {
            default = "󰎆 ";
            spotify = " ";
          };
          # max-length = 25;
          # on-click = "playerctl play-pause";
          return-type = "json";
        };
        "custom/power" = {
          format = " ";
          on-click = "bash ~/.config/rofi/leave/powermenu.sh";
          on-click-right = "killall rofi";
        };
        "custom/updater" = {
          exec = "yay -Qu | wc -l";
          exec-if = "[[ $(yay -Qu | wc -l) != 0 ]]";
          format = "  {} Updates";
          interval = 15;
          on-click = "alacritty -e yay -Syu";
        };
        height = 35;
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        keyboard-state = {
          capslock = true;
          format = " {name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
          numlock = true;
        };
        layer = "top";
        # margin-bottom = 10;
        # margin-top = 5;
        memory = {
          format = "{used:0.1f}G, {swapUsed:0.1f}G ";
        };
        modules-left = [
          "sway/workspaces"
        ];
        modules-right = [
          "custom/media"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "sway/language"
          "battery"
          "battery#bat2"
          "tray"
          "clock"
        ];
        network = {
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "Connected  ";
          format-linked = "{ifname} (No IP) 󰌸";
          format-wifi = "{essid} ({signalStrength}%) ";
          on-click-right = "bash ~/.config/rofi/wifi_menu/rofi_wifi_menu";
          tooltip-format = "{ifname} via {gwaddr} 󱄙";
        };
        position = "top";
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = "{icon} {format_source}";
          format-icons = {
            car = "";
            default = [
              ""
              ""
              ""
            ];
            hands-free = "";
            headphone = "";
            headset = "󰋎";
            phone = "";
            portable = "";
          };
          format-muted = "{format_source}";
          format-source = "";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        spacing = 4;
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "sway/workspaces" = {
          all-outputs = false;
          disable-scroll = true;
          format = "{name}";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        tray = {
          icon-size = 20;
          spacing = 10;
        };
      };
    };
    style = ./waybar.css;
  };
}
