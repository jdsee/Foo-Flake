{ ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ "kotlin" "nix" ];
    userSettings = {
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
      ui_font_size = 18;
      buffer_font_size = 18;
      theme = {
        mode = "system";
        light = "Tokyo Night";
        dark = "Tokyo Night";
      };
      active_pane_modifiers = {
        inactive_opacity = 0.8;
      };
      tab_bar = {
        show = false;
      };
      toolbar = {
        breadcrumbs = false;
        quick_actions = false;
      };
    };
  };
}
