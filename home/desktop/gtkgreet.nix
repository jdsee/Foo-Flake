{ pkgs, ... }:
{
  # TODO: Decide for one login manager and ditch the others

  home.packages = with pkgs; [
    cage
    greetd.gtkgreet
  ];
}
