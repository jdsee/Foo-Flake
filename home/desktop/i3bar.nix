{ pkgs, ... }: {
  home.packages = with pkgs; [
    i3bar-river
    i3status-rust
  ];

  xdg.configFile = {
    "i3bar-river/config.toml" = {
      text = ''
        font = "GeistMono Nerd Font 12"
        height = 30
        command = "${pkgs.i3status-rust}/bin/i3status-rs"

        [wm.river]
        max_tag = 10
      '';
    };
    "i3status-rust/config.toml" = {
      text = ''
        [theme]
        theme = "native"
        [theme.overrides]
        idle_fg = "#ebdbb2"
        info_fg = "#458588"
        good_fg = "#8ec07c"
        warning_fg = "#fabd2f"
        critical_fg = "#fb4934"

        icons_format = "{icon}"

        [icons]
        icons = "awesome6"
        [icons.overrides]
        bat = ["|E|", "|_|", "|=|", "|F|"]
        bat_charging = "|^| "

        [[block]]
        block = "cpu"
        info_cpu = 20
        warning_cpu = 50
        critical_cpu = 90

        # [[block]]
        # block = "disk_space"
        # path = "/"
        # info_type = "available"
        # alert_unit = "GB"
        # interval = 20
        # warning = 20.0
        # alert = 10.0
        # format = " $icon root: $available.eng(w:2) "

        [[block]]
        block = "memory"
        format = " $icon $mem_total_used_percents.eng(w:2) "
        format_alt = " $icon_swap $swap_used_percents.eng(w:2) "

        [[block]]
        block = "sound"
        [[block.click]]
        button = "left"
        cmd = "pavucontrol"

        [[block]]
        block = "time"
        interval = 5
        format = " $timestamp.datetime(f:'%a %d/%m %R') "
      '';
    };
  };
}
