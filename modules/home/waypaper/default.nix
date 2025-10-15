{ config, pkgs, ... }:

{
  xdg.configFile."waypaper/config.ini".source = ./config.ini;
}
