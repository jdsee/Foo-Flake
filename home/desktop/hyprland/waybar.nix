{ config, ... }:
{
  xdg.configFile = {
    "mako/status.sh" = {
      source = ../waybar/mako_status.sh;
      executable = true;
    };
  };
  programs.waybar = {
    enable = true;
    style = ../waybar/style.css;
    settings =
      let
        modules = {
          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
            };
          };

          "group/motherboard" = {
            "orientation" = "horizontal";
            "modules" = [
              "cpu"
              "memory"
              "temperature"
            ];
          };

          "group/laptop" = {
            "orientation" = "horizontal";
            "modules" = [
              "backlight"
              "battery"
            ];
          };

          "backlight" = {
            "interval" = 2;
            "align" = 0;
            "rotate" = 0;
            "format-icons" = [
              " "
              " "
              " "
              "󰃝 "
              "󰃞 "
              "󰃟 "
              "󰃠 "
            ];
            "format" = "{icon}";
            "tooltip-format" = "backlight {percent}%";
            "icon-size" = 10;
            "on-click" = "";
            "on-click-middle" = "";
            "on-click-right" = "";
            "on-update" = "";
            "on-scroll-up" = "brightnessctl set +5%";
            "on-scroll-down" = "brightnessctl set 5%-";
            "smooth-scrolling-threshold" = 1;
          };

          "battery" = {
            "align" = 0;
            "rotate" = 0;
            "full-at" = 100;
            "design-capacity" = false;
            "states" = {
              "good" = 95;
              "warning" = 30;
              "critical" = 15;
            };
            "format" = "{icon} {capacity}%";
            "format-charging" = " {capacity}%";
            "format-plugged" = "󱘖 {capacity}%";
            "format-alt-click" = "click";
            "format-full" = "{icon} Full";
            "format-alt" = "{icon} {time}";
            "format-icons" = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            "format-time" = "{H}h {M}min";
            "tooltip" = true;
            "tooltip-format" = "{timeTo} {power}w";
          };

          "clock" = {
            "interval" = 1;
            "format" = "{:%H:%M:%S}";
            "format-alt" = "{:%H:%M  %d %B, %A}";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              "mode" = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };

          "cpu" = {
            "format" = "{usage}% 󰍛";
            "interval" = 1;
            "format-alt-click" = "click";
            "format-alt" = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
            "format-icons" = [
              "▁"
              "▂"
              "▃"
              "▄"
              "▅"
              "▆"
              "▇"
              "█"
            ];
            "on-click-right" = "gnome-system-monitor";
          };

          "memory" = {
            "interval" = 10;
            "format" = "{used:0.1f}G 󰾆";
            "format-alt" = "{percentage}% 󰾆";
            "format-alt-click" = "click";
            "tooltip" = true;
            "tooltip-format" = "{used:0.1f}GB/{total:0.1f}G";
            "on-click-right" = "kitty --title btop sh -c 'btop'";
          };

          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "{icon} 󰂰 {volume}%";
            "format-muted" = "󰖁";
            "format-icons" = {
              "headphone" = "";
              "hands-free" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = [
                ""
                ""
                "󰕾"
                ""
              ];
              "ignored-sinks" = [
                "Easy Effects Sink"
              ];
            };
            "scroll-step" = 5.0;
            "on-click" = "pamixer --toggle-mute";
            "on-click-right" = "pavucontrol -t 3";
            "on-scroll-up" = "pamixer -i 5";
            "on-scroll-down" = "pamixer -d 5";
            "tooltip-format" = "{icon} {desc} | {volume}%";
            "smooth-scrolling-threshold" = 1;
          };

          "temperature" = {
            "interval" = 10;
            "tooltip" = true;
            "hwmon-path" = [
              "/sys/class/hwmon/hwmon1/temp1_input"
              "/sys/class/thermal/thermal_zone0/temp"
            ];
            "critical-threshold" = 82;
            "format-critical" = "{temperatureC}°C {icon}";
            "format" = "{temperatureC}°C {icon}";
            "format-icons" = [
              "󰈸"
            ];
            "on-click-right" = "kitty --title nvtop sh -c 'nvtop'";
          };

          "tray" = {
            "icon-size" = 18;
            "spacing" = 4;
          };

          "custom/separator#dot-line" = {
            "format" = "";
            "interval" = "once";
            "tooltip" = false;
          };

          "custom/mako" = {
            "exec" = "$XDG_CONFIG_HOME/mako/status.sh";
            "interval" = 2;
            "format" = "{}";
            "return-type" = "json";
          };
        };

        baseBar = {
          mod = "dock";
          layer = "top";
          position = "top";
          height = 40;
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          ipc = true;
          margin-top = 0;
          margin-left = 0;
          margin-right = 0;
        };

        primaryBar = baseBar // {
          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [
            "clock"
          ];

          modules-right = [
            "group/motherboard"
            "custom/separator#dot-line"
            "group/laptop"
            "custom/separator#dot-line"
            "pulseaudio"
            "custom/separator#dot-line"
            "custom/mako"
            "custom/separator#dot-line"
            "tray"
          ];
        };
      in
      {
        main = primaryBar // modules // {
          output = [ "eDP-1" "HDMI-A-1" ];

          "hyprland/workspaces" = modules."hyprland/workspaces" // {
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
              "6" = [ ];
              "7" = [ ];
              "8" = [ ];
              "9" = [ ];
              "10" = [ ];
            };
          };
        };

        primary = primaryBar // modules // {
          output = [ config.monitors.primary ];

          "hyprland/workspaces" = modules."hyprland/workspaces" // {
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
              "6" = [ ];
            };
          };
        };

        secondary = baseBar // {
          output = [ config.monitors.secondary ];

          modules-left = [
            "hyprland/workspaces"
          ];

          modules-right = [
            "clock"
          ];

          "hyprland/workspaces" = modules."hyprland/workspaces" // {
            persistent-workspaces = {
              "7" = [ ];
              "8" = [ ];
              "9" = [ ];
              "10" = [ ];
            };
          };

          "clock" = modules."clock" // {
            "format" = "{:%H:%M  %d %B, %A}";
          };
        };
      };
  };
}

