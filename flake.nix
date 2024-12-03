{
  description = "My personal NixOS and Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
    sops-nix.url = "github:Mic92/sops-nix";

    wayland-pipewire-idle-inhibit.url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
  };

  outputs =
    inputs @ { self, nixpkgs, home-manager, systems, sops-nix, ... }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs;
      formatter.${system} = pkgs.nixpkgs-fmt;
      overlays = import ./overlays { inherit inputs; };

      # nixos-rebuild switch --flake .#your-hostname
      nixosConfigurations = rec {
        default = transitus;

        transitus = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./host
            sops-nix.nixosModules.sops
          ];
        };
      };

      # home-manager switch --flake .#your-username@your-hostname
      homeConfigurations = {
        "jdsee@transitus" = home-manager.lib.homeManagerConfiguration {
          system = system;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/jdsee/transitus.nix
            inputs.wayland-pipewire-idle-inhibit.homeModules.default
          ];
        };
      };
    };
}
