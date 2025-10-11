{ pkgs, lib, ... }:

let
  waybarConfigDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    waybar
  ];

  home.sessionVariables = {
    WAYBAR_CONFIG = "${waybarConfigDir}/config.jsonc";
    WAYBAR_STYLE  = "${waybarConfigDir}/style.css";
  };

  home.file.".config/waybar/config.jsonc".source = "${waybarConfigDir}/config.jsonc";
  home.file.".config/waybar/style.css".source = "${waybarConfigDir}/style.css";
}

