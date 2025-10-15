{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ rmpc ];

  # Point directly to the config.ron file inside the repo
  xdg.configFile."rmpc/config.ron".source = ./config.ron;

  # Point to the themes folder
  xdg.configFile."rmpc/themes".source = ./themes;
}
