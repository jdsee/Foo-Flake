{ pkgs, ... }: {
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
    ./services/kanata.nix
  ];

  system.stateVersion = "24.05";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "transitus";
    networkmanager.enable = true;
  };

  powerManagement.powertop.enable = true;
  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    openssl
  ];

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

    # TODO: Try to disable xserver (videoDrivers might still be needed)
    xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us-custom";
        variant = "";
        extraLayouts.us-custom = {
          description = "My custom US layout";
          languages = [ "eng" ];
          symbolsFile = pkgs.writeText "xkb-layout" ''
            xkb_symbols "us-custom"
            {
              include "us(basic)"
              include "level3(ralt_switch)"

              key <LatA> { [ a, A, at ] };
              key <LatE> { [ e, E, exclam ] };
            };
          '';
        };
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
