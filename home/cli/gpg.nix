{ pkgs, ... }: {
  programs.gpg.enable = true;

  services = {
    ssh-agent.enable = false;
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      enableSshSupport = true;
    };
  };
}
