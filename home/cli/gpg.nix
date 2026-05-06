{ pkgs, ... }: {
  programs.gpg.enable = true;

  services = {
    ssh-agent.enable = false;
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-rofi;
      enableSshSupport = true;
    };
  };
}
