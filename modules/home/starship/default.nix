{ pkgs, lib, ... }:

let
  starshipConfigDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    starship
  ];

  # Optional: tell Starship where to find your config
  home.sessionVariables = {
    STARSHIP_CONFIG = "${starshipConfigDir}/starship.toml";
  };

  # Link the config file
  home.file.".config/starship.toml".source = "${starshipConfigDir}/starship.toml";
}

