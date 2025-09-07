{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        disable_loading_bar = false;
      };

      background = [
        {

          color = "rgb(55, 66, 49)";
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(49, 50, 68, 0.8)";
          font_color = "rgb(205, 214, 244)";
          fade_on_empty = false;
          font_family = "GeistMono Nerd Font";
          hide_input = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
          fail_color = "rgb(243, 139, 168)";
          check_color = "rgb(166, 227, 161)";
        }
      ];
    };
  };
}
