{ pkgs, lib, ... }:
let
  wofiConfigDir = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    wofi
  ];
  
  # Only copy the files you actually use
  home.file.".config/wofi/config".source = "${wofiConfigDir}/config";
  home.file.".config/wofi/style.css".source = "${wofiConfigDir}/style.css";
}