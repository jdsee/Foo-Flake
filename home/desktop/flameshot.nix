{ pkgs, ... }: 
let
  fshot = pkgs.writeShellScriptBin "fshot" ''
    export XDG_CURRENT_DESKTOP=sway
    export QT_QPA_PLATFORM=xcb
    export PATH=${pkgs.flameshot-grim}/bin:$PATH
    exec flameshot "$@"
  '';
in {
  home.packages = [ 
    pkgs.grim 
    fshot
  ];
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot-grim;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };
}
