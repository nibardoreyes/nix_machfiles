{ pkgs, lib, ... }:

let
  homeDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    matugen
  ];

  home.file.".config/matugen/config.toml".source = ./config.toml;
  home.file.".config/matugen/templates/kitty-colors.conf".source = ./templates/kitty-colors.conf;
}

