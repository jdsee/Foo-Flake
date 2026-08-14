{ pkgs, ... }: {

  programs.gpg.enable = true;

  home.packages = [ pkgs.gcr ];

  services = {
    ssh-agent.enable = false;
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-gnome3;
      enableSshSupport = true;
    };
  };
}
