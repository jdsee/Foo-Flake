{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./global
    ./users/jdsee

    ./systemd_boot.nix
    ./xdg-desktop-portal-wlr.nix
    ./yubikey.nix

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
    displayManager.sddm.enable = true;
    blueman.enable = true;
    openssh.enable = false;
    udisks2.enable = true;
    hardware.bolt.enable = true;
    printing.enable = true;

    xserver = {
      enable = true;
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
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
