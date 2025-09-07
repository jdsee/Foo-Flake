{
  description = "My personal NixOS and Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    wayland-pipewire-idle-inhibit.url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    linked-planet = {
      url = "git+ssh://git@github.com/linked-planet/nixified-onboarding.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs @ { self, nixpkgs, home-manager, systems, ... }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs;
      formatter.${system} = pkgs.nixpkgs-fmt;
      overlays = import ./overlays { inherit inputs; };

      # apps.${system} = {
      #   nvim = {
      #     program = {
      #       program = "${config.packages.neovim}/bin/nvim";
      #       type = "app";
      #     };
      #   };
      #
      #   tmpvim = {
      #     program = {
      #       program = pkgs.writeShellScriptBin "tmpvim" ''
      #         XDG_CONFIG_HOME=$(realpath .) ${config.packages.neovim}/bin/nvim
      #       '';
      #       type = "app";
      #     };
      #   };
      # };

      # nixos-rebuild switch --flake .#your-hostname
      # - Find conflicting HM file: journalctl -xe --unit home-manager-jdsee.service | grep 'is in the way'
      nixosConfigurations = rec {
        default = saxum;

        saxum = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./host
          ];
        };
      };

      # home-manager switch --flake .#your-username@your-hostname
      homeConfigurations = {
        "jdsee@saxum" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/saxum.nix
          ];
        };
      };

      devShells = {
        "${system}" = {
          default = pkgs.mkShell {
            shellHook = ''
              export
              PATH=$PWD/cmds:$PATH
            '';
          };
        };
      };
    };
}

