{ ... }:
# TODO: Replace all hypr/* scripts
{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      secondary = {
        mod = "dock";
        layer = "top";
        position = "top";
        output = [ "DP-3" ];
        height = 40;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        ipc = true;
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;

        modules-left = [
          "river/tags"
          "river/layout"
        ];

        modules-right = [
          "clock"
        ];

        "river/tags" = {
          num-tags = 10;
        };

        "clock" = {
          "interval" = 1;
          "format" = "{:%H:%M  %d %B, %A}";
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
      };
      primary = {
        mod = "dock";
        layer = "top";
        position = "top";
        output = [ "eDP-1" "DP-4" ];
        height = 40;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        ipc = true;
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;

        modules-left = [
          "river/tags"
          "river/layout"
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

        "river/tags" = {
          num-tags = 6;
        };

        "river/window" = {
          "format" = "{}";
        };

        "river/layout" = {
          "format" = "{}";
          "min-length" = 4;
          "align" = "right";
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

        "group/audio" = {
          "orientation" = "horizontal";
          "modules" = [
            "pulseaudio"
            "pulseaudio#microphone"
          ];
        };

        "backlight" = {
          "interval" = 2;
          "align" = 0;
          "rotate" = 0;
          #"format" = "{icon} {percent}%";
          "format-icons" = [
            " "
            " "
            " "
            "󰃝 "
            "󰃞 "
            "󰃟 "
            "󰃠 "
          ];
          "format" = "{icon}";
          #"format-icons" = ["";"","","","","","","","","","","","","",""],
          "tooltip-format" = "backlight {percent}%";
          "icon-size" = 10;
          "on-click" = "";
          "on-click-middle" = "";
          "on-click-right" = "";
          "on-update" = "";
          "on-scroll-up" = "~/.config/hypr/scripts/Brightness.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Brightness.sh --dec";
          "smooth-scrolling-threshold" = 1;
        };

        "battery" = {
          # "interval" = 5;
          "align" = 0;
          "rotate" = 0;
          # "bat" = "BAT1";
          # "adapter" = "ACAD";
          "full-at" = 100;
          "design-capacity" = false;
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
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
          "on-click-middle" = "~/.config/hypr/scripts/ChangeBlur.sh";
          "on-click-right" = "~/.config/hypr/scripts/Wlogout.sh";
        };

        "bluetooth" = {
          "format" = "";
          "format-disabled" = "󰂳";
          "format-connected" = "󰂱 {num_connections}";
          "tooltip-format" = " {device_alias}";
          "tooltip-format-connected" = "{device_enumerate}";
          "tooltip-format-enumerate-connected" = " {device_alias} 󰂄{device_battery_percentage}%";
          "tooltip" = true;
          "on-click" = "blueman-manager";
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

        "actions" = {
          "on-click-right" = "mode";
          "on-click-forward" = "tz_up";
          "on-click-backward" = "tz_down";
          "on-scroll-up" = "shift_up";
          "on-scroll-down" = "shift_down";
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

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = " ";
            "deactivated" = " ";
          };
        };

        "keyboard-state" = {
          # "numlock" = true;
          "capslock" = true;
          "format" = {
            "numlock" = "N {icon}";
            "capslock" = "󰪛 {icon}";
          };
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
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

        "mpris" = {
          "interval" = 10;
          "format" = "{player_icon} ";
          "format-paused" = "{status_icon} <i>{dynamic}</i>";
          "on-click-middle" = "playerctl play-pause";
          "on-click" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "scroll-step" = 5.0;
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --dec";
          "smooth-scrolling-threshold" = 1;
          "player-icons" = {
            "chromium" = "";
            "default" = "";
            "firefox" = "";
            "kdeconnect" = "";
            "mopidy" = "";
            "mpv" = "󰐹";
            "spotify" = "";
            "vlc" = "󰕼";
          };
          "status-icons" = {
            "paused" = "󰐎";
            "playing" = "";
            "stopped" = "";
          };
          #  "ignored-players" = ["firefox"]
          "max-length" = 30;
        };

        "network" = {
          "format" = "{ifname}";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰌘";
          "format-disconnected" = "󰌙";
          "tooltip-format" = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-linked" = "󰈁 {ifname} (No IP)";
          "tooltip-format-wifi" = "{essid} {icon} {signalStrength}%";
          "tooltip-format-ethernet" = "{ifname} 󰌘";
          "tooltip-format-disconnected" = "󰌙 Disconnected";
          "max-length" = 50;
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
        };

        "network#speed" = {
          "interval" = 1;
          "format" = "{ifname}";
          "format-wifi" = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-ethernet" = "󰌘   {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-disconnected" = "󰌙";
          "tooltip-format" = "{ipaddr}";
          "format-linked" = "󰈁 {ifname} (No IP)";
          "tooltip-format-wifi" = "{essid} {icon} {signalStrength}%";
          "tooltip-format-ethernet" = "{ifname} 󰌘";
          "tooltip-format-disconnected" = "󰌙 Disconnected";
          "max-length" = 50;
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
        };

        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} 󰂰 {volume}%";
          "format-muted" = "󰖁";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              "󰕾"
              ""
            ];
            "ignored-sinks" = [
              "Easy Effects Sink"
            ];
          };
          "scroll-step" = 5.0;
          "on-click" = "~/.config/hypr/scripts/Volume.sh --toggle";
          "on-click-right" = "pavucontrol -t 3";
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --dec";
          "tooltip-format" = "{icon} {desc} | {volume}%";
          "smooth-scrolling-threshold" = 1;
        };

        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "on-click" = "~/.config/hypr/scripts/Volume.sh --toggle-mic";
          "on-click-right" = "pavucontrol -t 4";
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --mic-inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --mic-dec";
          "tooltip-format" = "{source_desc} | {source_volume}%";
          "scroll-step" = 5;
        };

        "temperature" = {
          "interval" = 10;
          "tooltip" = true;
          "hwmon-path" = [
            "/sys/class/hwmon/hwmon1/temp1_input"
            "/sys/class/thermal/thermal_zone0/temp"
          ];
          # "thermal-zone" = 0;
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

        "wireplumber" = {
          "format" = "{icon} {volume} %";
          "format-muted" = " Mute";
          "on-click" = "~/.config/hypr/scripts/Volume.sh --toggle";
          "on-click-right" = "pavucontrol -t 3";
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --dec";
          "format-icons" = [
            ""
            ""
            "󰕾"
            ""
          ];
        };

        "wlr/taskbar" = {
          "format" = "{icon} {name} ";
          "icon-size" = 15;
          "all-outputs" = false;
          "tooltip-format" = "{title}";
          "on-click" = "activate";
          "on-click-middle" = "close";
          "ignore-list" = [
            "wofi"
            "rofi"
          ];
        };

        "custom/cycle_wall" = {
          "format" = " ";
          "exec" = "echo ; echo 󰸉 wallpaper select";
          "on-click" = "~/.config/hypr/UserScripts/WallpaperSelect.sh";
          "on-click-right" = "~/.config/hypr/UserScripts/WallpaperRandom.sh";
          "on-click-middle" = "~/.config/hypr/scripts/WaybarStyles.sh";
          "interval" = 86400; #  once every day
          "tooltip" = true;
        };

        "custom/hint" = {
          "format" = "󰺁 HINT!";
          "exec" = "echo ; echo  Key Hints SUPER H";
          "on-click" = "~/.config/hypr/scripts/KeyHints.sh";
          "interval" = 86400; #  once every day
          "tooltip" = true;
        };

        "custom/keyboard" = {
          "exec" = "cat ~/.cache/kb_layout";
          "interval" = 1;
          "format" = " {}";
          "on-click" = "~/.config/hypr/scripts/SwitchKeyboardLayout.sh";
        };

        "custom/light_dark" = {
          "format" = "󰔎{}";
          "exec" = "echo ; echo 󰔎 Dark-Light switcher";
          "on-click" = "~/.config/hypr/scripts/DarkLight.sh";
          "on-click-right" = "~/.config/hypr/scripts/WaybarStyles.sh";
          "on-click-middle" = "~/.config/hypr/UserScripts/WallpaperSelect.sh";
          "interval" = 86400; #  once every day
          "tooltip" = true;
        };

        "custom/lock" = {
          "format" = "󰌾{}";
          "exec" = "echo ; echo 󰷛  screen lock";
          "interval" = 86400; #  once every day
          "tooltip" = true;
          "on-click" = "~/.config/hypr/scripts/LockScreen.sh";
        };

        "custom/menu" = {
          "format" = "{}";
          "exec" = "echo ; echo 󱓟 app launcher";
          "interval" = 86400; #  once every day
          "tooltip" = true;
          "on-click" = "pkill rofi || rofi -show drun -modi run;drun,filebrowser,window";
          "on-click-middle" = "~/.config/hypr/UserScripts/WallpaperSelect.sh";
          "on-click-right" = "~/.config/hypr/scripts/WaybarLayout.sh";
        };

        "custom/cava_mviz" = {
          "exec" = "~/.config/hypr/scripts/WaybarCava.sh";
          "format" = "{}";
        };

        "custom/playerctl" = {
          "format" = "<span>{}</span>";
          "return-type" = "json";
          "max-length" = 35;
          "exec" = "playerctl -a metadata --format '{\"text\": \"{{artist}} ~ {{markup_escape(title)}}\"; \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click-middle" = "playerctl play-pause";
          "on-click" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "scroll-step" = 5.0;
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --dec";
          "smooth-scrolling-threshold" = 1;
        };

        "custom/power" = {
          "format" = "⏻ ";
          "exec" = "echo ; echo 󰟡 power #  blur";
          "on-click" = "~/.config/hypr/scripts/Wlogout.sh";
          "on-click-right" = "~/.config/hypr/scripts/ChangeBlur.sh";
          "interval" = 86400; #  once every day
          "tooltip" = true;
        };

        "custom/swaync" = {
          "tooltip" = true;
          "format" = "{icon} {}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "sleep 0.1 && swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };

        "custom/weather" = {
          "format" = "{}";
          "format-alt" = "{alt}: {}";
          "format-alt-click" = "click";
          "interval" = 3600;
          "return-type" = "json";
          "exec" = "~/.config/hypr/UserScripts/Weather.sh";
          "exec-if" = "ping wttr.in -c1";
          "tooltip" = true;
        };

        "custom/separator#dot" = {
          "format" = "";
          "interval" = "once";
          "tooltip" = false;
        };

        "custom/separator#dot-line" = {
          "format" = "";
          "interval" = "once";
          "tooltip" = false;
        };

        "custom/separator#line" = {
          "format" = "|";
          "interval" = "once";
          "tooltip" = false;
        };

        "custom/separator#blank" = {
          "format" = "";
          "interval" = "once";
          "tooltip" = false;
        };

        "custom/separator#blank_2" = {
          "format" = "  ";
          "interval" = "once";
          "tooltip" = false;
        };

        "custom/separator#blank_3" = {
          "format" = "   ";
          "interval" = "once";
          "tooltip" = false;
        };

        #  Modules below are for vertical layout
        "backlight#vertical" = {
          "interval" = 2;
          "align" = 0.35;
          "rotate" = 1;
          "format" = "{icon}";
          # "format-icons" = ["󰃞"; "󰃟", "󰃠"],
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          "on-click" = "";
          "on-click-middle" = "";
          "on-click-right" = "";
          "on-update" = "";
          "on-scroll-up" = "~/.config/hypr/scripts/Brightness.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Brightness.sh --dec";
          "smooth-scrolling-threshold" = 1;
          "tooltip-format" = "{percent}%";
        };

        "clock#vertical" = {
          "format" = "\n{:%H\n%M\n%S\n\n \n%d\n%m\n%y}";
          "interval" = 1;
          # "format" = "\n{:%I\n%M\n%p\n\n \n%d\n%m\n%y}";
          "tooltip" = true;
          "tooltip-format" = "{calendar}";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "format" = {
              "today" = "<span color='#0dbc79'>{}</span>";
            };
          };
        };

        "cpu#vertical" = {
          "format" = "󰍛\n{usage}%";
          "interval" = 1;
          "on-click-right" = "gnome-system-monitor";
        };

        "memory#vertical" = {
          "interval" = 10;
          "format" = "󰾆\n{percentage}%";
          "format-alt" = "󰾆\n{used:0.1f}G";
          "format-alt-click" = "click";
          "tooltip" = true;
          "tooltip-format" = "{used:0.1f}GB/{total:0.1f}G";
          "on-click-right" = "kitty --title btop sh -c 'btop'";
        };

        "pulseaudio#vertical" = {
          "format" = "{icon}";
          "format-bluetooth" = "󰂰";
          "format-muted" = "󰖁";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              "󰕾"
              ""
            ];
            "tooltip-format" = "{icon} {desc} | {volume}%";
            "ignored-sinks" = [
              "Easy Effects Sink"
            ];
          };
          "scroll-step" = 5.0;
          "on-click" = "~/.config/hypr/scripts/Volume.sh --toggle";
          "on-click-right" = "pavucontrol -t 3";
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --dec";
          "tooltip-format" = "{icon} {desc} | {volume}%";
          "smooth-scrolling-threshold" = 1;
        };

        "pulseaudio#microphone_vertical" = {
          "format" = "{format_source}";
          "format-source" = "󰍬";
          "format-source-muted" = "󰍭";
          "on-click-right" = "pavucontrol";
          "on-click" = "~/.config/hypr/scripts/Volume.sh --toggle-mic";
          "on-scroll-up" = "~/.config/hypr/scripts/Volume.sh --mic-inc";
          "on-scroll-down" = "~/.config/hypr/scripts/Volume.sh --mic-dec";
          "max-volume" = 100;
          "tooltip" = true;
          "tooltip-format" = "{source_desc} | {source_volume}%";
        };

        "temperature#vertical" = {
          "interval" = 10;
          "tooltip" = true;
          "hwmon-path" = [
            "/sys/class/hwmon/hwmon1/temp1_input"
            "/sys/class/thermal/thermal_zone0/temp"
          ];
          # "thermal-zone" = 0;
          "critical-threshold" = 80;
          "format-critical" = "{icon}\n{temperatureC}°C";
          "format" = " {icon}";
          "format-icons" = [
            "󰈸"
          ];
          "on-click-right" = "kitty --title nvtop sh -c 'nvtop'";
        };

        "custom/power_vertical" = {
          "format" = "⏻";
          "exec" = "echo ; echo 󰟡 power #  blur";
          "on-click" = "~/.config/hypr/scripts/Wlogout.sh";
          "on-click-right" = "~/.config/hypr/scripts/ChangeBlur.sh";
          "interval" = 86400; #  once every day
          "tooltip" = true;
        };

        "custom/mako" = {
          "exec" = "$XDG_CONFIG_HOME/mako/status.sh";
          "interval" = 2;
          "format" = "{}";
          "return-type" = "json";
        };
      };
    };
  };

  xdg.configFile = {
    "mako/status.sh" = {
      source = ./mako_status.sh;
      executable = true;
    };
  };
}
