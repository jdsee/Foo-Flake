{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
