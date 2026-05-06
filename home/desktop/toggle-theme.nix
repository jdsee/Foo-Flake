{ pkgs, config, ... }:
let
  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    current=$(gsettings get org.gnome.desktop.interface color-scheme)

    if [[ "$current" == "'prefer-dark'" ]]; then
      echo "Switching to light mode..."
      gsettings set org.gnome.desktop.interface color-scheme prefer-light
      gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Light
      gsettings set org.gnome.desktop.interface icon-theme WhiteSur
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"

      hyprctl hyprpaper wallpaper ",${config.wallpaper.light.primary}"
      hyprctl hyprpaper wallpaper "desc:${config.monitors.secondary},${config.wallpaper.light.secondary}"
    else
      echo "Switching to dark mode..."
      gsettings set org.gnome.desktop.interface color-scheme prefer-dark
      gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Dark
      gsettings set org.gnome.desktop.interface icon-theme WhiteSur-Dark
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"

      hyprctl hyprpaper wallpaper ",${config.wallpaper.dark.primary}"
      hyprctl hyprpaper wallpaper "desc:${config.monitors.secondary},${config.wallpaper.dark.secondary}"
    fi
  '';
  reset-theme = pkgs.writeShellScriptBin "reset-theme" "toggle-theme && toggle-theme";
in
{
  home.packages = with pkgs;
    [
      glib # provides gsettings
      toggle-theme
      reset-theme
    ];
}

