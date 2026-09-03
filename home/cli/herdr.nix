{ pkgs, ... }:
{
  home.packages = with pkgs; [
    herdr
    python3 # Required for usage as mux backend
  ];

  home.sessionVariables = {
    MUX_BACKEND = "herdr";
  };

  # programs.herdr = {
  #   enable = true;
  #   settings = {
  #     keys = {
  #       prefix = "ctrl+f";
  #       split_vertical = "prefix+|";
  #       previous_workspace = "prefix+L";
  #     };
  #     ui = {
  #       sidebar_start_collapsed = true;
  #       sidebar_collapsed_mode = "hidden";
  #       hide_tab_bar_when_single_tab = true;
  #       pane_gaps = false;
  #       pane_borders = true;
  #       pane_outer_borders = false;
  #       sound = {
  #         enabled = false;
  #       };
  #       toast = {
  #         delivery = "off";
  #       };
  #     };
  #   };
  # };
}
