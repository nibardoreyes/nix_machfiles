{
  description = "Nibardo's NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    matugen = {
      url = "github:/InioX/Matugen";
    };
    sddm-sugar-candy-nix = {
      url = "github:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, matugen, sddm-sugar-candy-nix, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          # Import Sugar Candy module
          sddm-sugar-candy-nix.nixosModules.default
          
          # Apply overlay BEFORE your theme config
          {
            nixpkgs.overlays = [ 
              sddm-sugar-candy-nix.overlays.default 
            ];
          }
          
          # Your theme configuration
          ./modules/system/sddm/sddm-theme.nix
          
          # Matugen module
          matugen.nixosModules.default
        ];
      };
      
      homeConfigurations.nibardo = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./home.nix 
        ];
      };
    };
}
