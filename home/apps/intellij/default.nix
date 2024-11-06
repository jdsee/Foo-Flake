{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];
  xdg.configFile = {
    "ideavim/ideavimrc".source = ./ideavimrc;
  };
}
