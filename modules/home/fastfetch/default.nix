{ pkgs, lib, ... }:

let
  fastfetchConfigDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    fastfetch
  ];

  # Optional: tell Fastfetch where to find your config
  home.sessionVariables = {
    FASTFETCH_CONFIG = "${fastfetchConfigDir}/config.jsonc";
  };

  # Link config.jsonc
  home.file.".config/fastfetch/config.jsonc".source = "${fastfetchConfigDir}/config.jsonc";

  # Link PNGs folder (for logos)
  home.file.".config/fastfetch/pngs".source = "${fastfetchConfigDir}/pngs";
  home.file.".config/fastfetch/pngs".recursive = true;
}

