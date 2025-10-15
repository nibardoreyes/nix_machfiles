{
  description = "Minimal C++ project";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # Compiler
            gcc
            
            # Build tools
            cmake
            gnumake
            
            # Development tools
            clang-tools  # clang-format, clang-tidy
            gdb
          ];
          
          shellHook = ''
            echo "⚙️  C++ development environment ready"
            echo "🔧 gcc $(gcc --version | head -n1)"
            echo "📦 cmake $(cmake --version | head -n1)"
          '';
        };
      }
    );
}
