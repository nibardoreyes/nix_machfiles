{
  description = "Minimal JavaScript project";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nodeVersion = pkgs.nodejs_22;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            nodeVersion
            pkgs.nodePackages.typescript
            pkgs.nodePackages.eslint
            # Add more packages here
          ];
          
          shellHook = ''
            echo "📦 Node ${nodeVersion.version} environment ready"
            echo "🔧 npm $(npm --version)"
          '';
        };
      }
    );
}
