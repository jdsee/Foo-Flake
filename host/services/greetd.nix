{ pkgs, ... }:
let
  cage = "${pkgs.cage}/bin/cage";
  gtkgreet = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${cage} ${gtkgreet}";
        user = "jdsee";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    river
    zsh
  '';
}
