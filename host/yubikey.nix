{ pkgs, ... }: {
  programs.ssh.startAgent = false;
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;
  environment.systemPackages = with pkgs; [
    libusbp
    libykclient
    pcsc-tools
    stable.yubikey-manager
    yubikey-personalization
    stable.yubioath-flutter
    zenity
  ];

  services = {
    udev.packages = with pkgs.stable; [
      # yubikey-personalization
      yubikey-manager
      yubioath-flutter
    ];
    yubikey-agent.enable = false;
  };
}
