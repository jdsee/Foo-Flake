{ pkgs, lib, ... }:
let
  cage = lib.getExe pkgs.cage;
  gtkgreet = lib.getExe pkgs.greetd.gtkgreet;
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${cage} -d -s -m last ${gtkgreet}";
        user = "jdsee";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    river
    zsh
  '';
}
