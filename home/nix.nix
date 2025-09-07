{ lib
, pkgs
, config
, outputs
, inputs
, ...
}: {
  imports = [
    ./cli
    ./nvim
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays ++
      [
        inputs.nur.overlays.default
      ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowBroken = true;
      permittedInsecurePackages = [ ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "jdsee";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
  };
}
