{ pkgs, lib, ... }:
let
  swayNC_ConfigDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];
  
  # Main config files
  home.file.".config/swaync/config.json".source = "${swayNC_ConfigDir}/config.json";
  home.file.".config/swaync/style.css".source = "${swayNC_ConfigDir}/style.css";
  
  # Refresh script
  home.file.".config/swaync/refresh.sh" = {
    source = "${swayNC_ConfigDir}/refresh.sh";
    executable = true;
  };
}