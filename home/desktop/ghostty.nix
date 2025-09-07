{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "dark:neobones_dark,light:neobones_light";
      font-family = "GeistMono Nerd Font";
      font-size = 15;
      mouse-hide-while-typing = true;
      gtk-tabs-location = "hidden";
      window-decoration = "none";
      gtk-single-instance = true;
      confirm-close-surface = false;

      keybind = [
        "alt+r=reload_config"
        "ctrl+enter=unbind"
      ];
    };
  };
}
