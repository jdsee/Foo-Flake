{ pkgs, ... }:
let
  timeoutInSeconds = 15 * 60;
in
{
  programs.rbw = {
    enable = true;
    settings = {
      email = "joscha-seelig@protonmail.com";
      lock_timeout = timeoutInSeconds;
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
