{ pkgs, ... }:
let
  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    current=$(gsettings get org.gnome.desktop.interface color-scheme)

    if [[ "$current" == "'prefer-dark'" ]]; then
      echo "Switching to light mode..."
      gsettings set org.gnome.desktop.interface color-scheme prefer-light
      gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Light
      gsettings set org.gnome.desktop.interface icon-theme WhiteSur
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      new_theme="light"
    else
      echo "Switching to dark mode..."
      gsettings set org.gnome.desktop.interface color-scheme prefer-dark
      gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Dark
      gsettings set org.gnome.desktop.interface icon-theme WhiteSur-Dark
      dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      new_theme="dark"
    fi

    # # Signal Ghostty to reload config (if running)
    # for pid in $(pgrep ghostty); do
    #   if kill -0 "$pid" 2>/dev/null; then
    #     echo "Signaling Ghostty (PID: $pid) to reload config..."
    #     kill -USR2 "$pid" || true
    #   fi
    # done
  '';
in
{
  home.packages = with pkgs;
    [
      glib # provides gsettings
      toggle-theme
    ];
}

