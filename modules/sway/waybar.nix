{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "sway-session.target";
    settings = {
      main = {
        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "network" "cpu" "memory" "temperature" "clock" "battery" ];

        network = {
          format-ethernet = "{ipaddr}/{cidr} ";
          format-wifi = "{essid} ({signalStrength} %) ";
        };

        cpu = {
          format = "{usage}% ";
        };

        memory = {
          format = "{used:0.1f}G/{total:0.1f}G {percentage}%, {swapUsed:0.1f}G sw ";
        };

        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
      };
    };
    style = ./waybar.css;
  };
}
