{ ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./config.lua;
  };

  home.sessionVariables = {
    # TODO:
    # TERMINAL = "wezterm";
  };
}
