{ pkgs, config, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./global
    ./users/jdsee

    ./systemd-boot.nix
    ./xdg-desktop-portal.nix
    ./yubikey.nix
    ./nvidia.nix
    ./obs-virtual-cam.nix
    ./steam.nix

    ./services/docker.nix
    ./services/greetd.nix
    ./services/pipewire.nix
    ./services/polkit.nix
    ./services/kanata.nix
  ];

  system.stateVersion = "24.05";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-059042ae-dbcd-4cb8-bb6d-87e4ab50830f".device = "/dev/disk/by-uuid/059042ae-dbcd-4cb8-bb6d-87e4ab50830f";

  networking = {
    hostName = "saxum";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };
  };

  powerManagement.powertop.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    openssl
  ];

  security = {
    rtkit.enable = true;
    pki.certificateFiles = builtins.map (name: ../secrets/cert + "/${name}")
      (builtins.attrNames (builtins.readDir ../secrets/cert));
  };

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
    usbmuxd.enable = true;
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-udevd.restartIfChanged = false;
  };

  hardware = {
    bluetooth.enable = true;
  };
}
