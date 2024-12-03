{ pkgs, ... }:
{
  programs.tofi = {
    enable = true;
    settings = {
      font = "${pkgs.geist-font}/share/fonts/opentype/GeistMono-Regular.otf";
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 7;
      selection-color = "#F79B56";
      background-color = "#000E";
    };
  };
}
