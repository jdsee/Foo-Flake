{ pkgs, ... }:
let
  shoot = pkgs.writeShellScriptBin "shoot" ''
    case "$1" in
      "region")
        grim -g "$(slurp)" - | satty --filename -
        ;;
      "screen")
        grim -o "$(slurp -o)" - | satty --filename -
        ;;
      "raw")
        grim -o "$(slurp -o)" -
        ;;
      "all")
        grim -
        ;;
      *)
        echo "Usage: shoot [region|screen|raw]"
        exit 1
        ;;
    esac
  '';
in
{
  home.packages = with pkgs; [
    grim
    slurp
    shoot
  ];
  programs.satty = {
    enable = true;
    settings = {
      general = {
        early-exit = true;
        copy-command = "wl-copy";
        initial-tool = "rectangle";
        output-filename = "/tmp/screenshot-%Y-%m-%d_%H:%M:%S.png";
      };
      color-palette = {
        # palette = [ "#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000" ];
      };
    };
  };
}
