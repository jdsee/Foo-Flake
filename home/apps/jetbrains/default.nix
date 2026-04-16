{ pkgs, ... }: {
  imports = [
    ./idea-cli.nix
  ];
  home.packages = with pkgs.jetbrains; [
    idea
  ];
  xdg.configFile = {
    "ideavim/ideavimrc".source = ./ideavimrc;
  };
}
