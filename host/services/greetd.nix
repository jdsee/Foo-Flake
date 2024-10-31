{ ... }:
{
  programs.regreet.enable = true;

  services.greetd = {
    enable = true;
  };

  environment.etc."greetd/environments".text = ''
    river
    zsh
  '';
}
