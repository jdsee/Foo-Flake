{ pkgs, ... }:
let
  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    current=$(gsettings get org.gnome.desktop.interface color-scheme)
    if [[ "$current" == "'prefer-dark'" ]]; then
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
      gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
      gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur'
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
      gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
    fi
  '';
in
{
  home.packages = with pkgs;
    [
      glib # provides gsettings
      toggle-theme
    ];
}

