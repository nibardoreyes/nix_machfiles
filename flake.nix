{
  description = "Nibardo's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sddm-sugar-candy-nix = {
      url = "github:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sddm-sugar-candy-nix, ... }:
    let
      system = "x86_64-linux";
    in {
      # NixOS system configuration
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          ./modules/system/system.nix
        ];

        # Pass the SDDM flake module into system.nix
        specialArgs = { inherit sddm-sugar-candy-nix; };
      };

      # Home Manager configuration
      homeConfigurations.nibardo = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./modules/home/home.nix
        ];
      };
    };
}
