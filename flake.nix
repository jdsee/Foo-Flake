{
  description = "My personal NixOS and Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , flake-utils
    , xremap-flake
    , ...
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      packages = nixpkgs.legacyPackages.${system};
      formatter = nixpkgs.legacyPackages.${system}.alejandra;
      overlays = import ./overlays { inherit inputs; };

      # nixos-rebuild switch --flake .#your-hostname
      nixosConfigurations = {
        transitus = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./host
            xremap-flake.nixosModules.default
          ];
        };
      };

      # home-manager switch --flake .#your-username@your-hostname
      homeConfigurations = {
        "jdsee@transitus" = home-manager.lib.homeManagerConfiguration {
          system = system;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jdsee/transitus.nix ];
        };
      };
    };
}
