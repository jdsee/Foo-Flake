{ ... }:
{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      style = "compact";
      inline_height = 20;
      invert = true;
      show_preview = true;
      show_help = false;
    };
  };
}
