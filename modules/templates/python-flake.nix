{
  description = "Minimal Python project";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonVersion = pkgs.python312;
        
        pythonEnv = pythonVersion.withPackages (ps: with ps; [
          pandas
          # Add more packages here
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonEnv
            pkgs.ruff  # Fast Python linter
            pkgs.pyright  # Type checker
          ];
          
          shellHook = ''
            echo "🐍 Python ${pythonVersion.version} environment ready"
            echo "📦 Packages: $(python -c 'import pandas; print(f"pandas {pandas.__version__}")')"
          '';
        };
      }
    );
}
