{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "fastfetch-config";
  version = "1.0";

  # No sources needed, just config files
  src = ./.;

  buildInputs = [ pkgs.fastfetch ];

  installPhase = ''
    mkdir -p $out/.config/fastfetch/pngs
    mkdir -p $out/.config/fastfetch

    # Copy your config.jsonc
    cp ${./config.jsonc} $out/.config/fastfetch/config.jsonc

    # Copy all PNGs (optional)
    cp -r ${./pngs}/* $out/.config/fastfetch/pngs/
  '';

  meta = with pkgs.lib; {
    description = "Fastfetch configuration for Nibardo";
    license = licenses.mit;
    maintainers = [ maintainers.nibardo ];
  };
}

