{ pkgs, ... }:
{
  programs.ssh.startAgent = false;
  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    yubikey-personalization
  ];
}
