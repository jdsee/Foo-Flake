{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./global
    ./users/jdsee

    ./systemd-boot.nix
    ./xdg-desktop-portal.nix
    ./yubikey.nix
    ./nvidia.nix
    ./obs-virtual-cam.nix

    ./services/docker.nix
    ./services/greetd.nix
    ./services/pipewire.nix
    ./services/polkit.nix
    ./services/xremap.nix
  ];

  system.stateVersion = "24.05";

  networking = {
    hostName = "transitus";
    networkmanager.enable = true;
  };

  powerManagement.powertop.enable = true;
  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh.enable = true;
    light.enable = true;
    dconf.enable = true;
    adb.enable = false;
    kdeconnect.enable = false;
  };

  services = {
    dbus.enable = true;
    blueman.enable = true;
    openssh.enable = false;
    udisks2.enable = true;
    hardware.bolt.enable = true;
    printing.enable = true;

    xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-udevd.restartIfChanged = false;
  };

  hardware = {
    bluetooth.enable = true;
  };
}
