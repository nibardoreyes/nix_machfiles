{ pkgs, lib, ... }:
let
  waybarConfigDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    waybar
  ];
  
  home.sessionVariables = {
    WAYBAR_CONFIG = "${waybarConfigDir}/config";
    WAYBAR_STYLE  = "${waybarConfigDir}/style.css";
    WAYBAR_LAUNCH = "${waybarConfigDir}/launch.sh";
  };
  
  # Main config files
  home.file.".config/waybar/config".source = "${waybarConfigDir}/config";
  home.file.".config/waybar/style.css".source = "${waybarConfigDir}/style.css";
  
  # Assets directory
  home.file.".config/waybar/assets" = {
    source = "${waybarConfigDir}/assets";
    recursive = true;
  };
  
  # Scripts directory
  home.file.".config/waybar/scripts/colorpicker.sh" = {
    source = "${waybarConfigDir}/scripts/colorpicker.sh";
    executable = true;
  };
  home.file.".config/waybar/scripts/refresh.sh" = {
    source = "${waybarConfigDir}/scripts/refresh.sh";
    executable = true;
  };
  home.file.".config/waybar/scripts/select.sh" = {
    source = "${waybarConfigDir}/scripts/select.sh";
    executable = true;
  };
  
  # Themes directory
  home.file.".config/waybar/themes" = {
    source = "${waybarConfigDir}/themes";
    recursive = true;
  };
}