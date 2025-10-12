{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    matugen = {
      url = "github:/InioX/Matugen";
    };
  };

  outputs = { self, nixpkgs, home-manager, matugen, ...}:
     let
        lib = nixpkgs.lib;
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
     in {
     nixosConfigurations = {
        nixos = lib.nixosSystem {
	   inherit system;
	   modules = [ 
	     ./configuration.nix 
	     matugen.nixosModules.default
	   ];
	};
    };
    homeConfigurations = {
       nibardo = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
       };
    };
  };
}
