{ pkgs, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./nix-ld.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "bak";
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  networking.networkmanager.enable = true;

  security = {
    pam.services = {
      waylock = { };
      swaylock = { };
      hyprlock.text = "auth include login";
    };
  };

  environment = {
    enableAllTerminfo = true;
    sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  programs.fuse.userAllowOther = true;
  hardware.enableRedistributableFirmware = true;
}
