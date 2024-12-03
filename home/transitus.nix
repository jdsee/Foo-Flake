{ pkgs, inputs, ... }:
let
  apps = with pkgs; [
    google-chrome
    ferdium
    signal-desktop
    element-desktop
    slack
    youtube-music
  ];
  utils = with pkgs; [
    bitwarden
    brightnessctl
    gopass
    gparted
    ntfs3g
    exfatprogs
    lswt # List wayland toplevels
    slurp
    networkmanagerapplet
    pamixer
    playerctl
  ];
in
{
  imports = [
    ./global.nix
    ./desktop
    ./lang/c.nix
    ./apps/firefox.nix
    ./apps/obs.nix
    ./apps/jetbrains
    ./apps/zathura.nix
    ./apps/zed.nix
  ];

  home.packages = apps ++ utils;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [ ];
    };
  };
}
