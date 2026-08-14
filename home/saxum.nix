{ pkgs, inputs, ... }:
let
  apps = with pkgs; [
    discord
    # freecad
    chromium
    qutebrowser
    obsidian
    signal-desktop
    slack
    # davinci-resolve <- buggy under wayland :(

    # Electron Multi-App Wrapper (TODO: choose one)
    ferdium
    franz
    rambox
    libreoffice
  ];
  utils = with pkgs; [
    bitwarden-desktop
    brightnessctl
    exfatprogs
    gopass
    gparted
    lswt # list wayland toplevels
    networkmanagerapplet
    ntfs3g
    pamixer
    playerctl
    rustup
  ];
in
{
  imports = [
    ./nix.nix
    ./desktop
    ./lang/c.nix
    ./apps/firefox.nix
    ./apps/obs.nix
    ./apps/jetbrains
    ./apps/zathura.nix
    ./apps/zed.nix
  ];

  home.packages = apps ++ utils;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];
}
