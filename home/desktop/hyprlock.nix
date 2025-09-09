{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = [
        {
          monitor = "";
          path = "/home/jdsee/.config/wallpaper/Road-Trip_2560x1440.png";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 25;
          font_family = "Geist Mono Nerd Font";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%I:%M\")</span>\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 120;
          font_family = "Geist Mono Nerd Font";
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(216, 222, 233, 0.80)";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          font_size = 18;
          font_family = "Geist Mono Nerd Font";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [
        {
          monitor = "";
          size = "300, 60";
          color = "rgba(255, 255, 255, .1)";
          rounding = -1;
          border_size = 0;
          border_color = "rgba(253, 198, 135, 0)";
          rotate = 0;
          xray = false;
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "Geist Mono Nerd Font";
          placeholder_text = "<i><span foreground=\"##ffffff99\">Enter Password</span></i>";
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
