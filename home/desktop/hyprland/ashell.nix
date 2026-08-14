{ ... }: {
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      appearance = {
        style = "Solid";
      };
      # modules = {
      #   center = [
      #     "Clock"
      #     "Window Title"
      #   ];
      #   left = [
      #     "Workspaces"
      #   ];
      #   right = [
      #     "SystemInfo"
      #     [
      #       "Privacy"
      #       "Settings"
      #     ]
      #   ];
      # };
      # workspaces = {
      #   visibilityMode = "MonitorSpecific";
      # };
    };
  };
}
