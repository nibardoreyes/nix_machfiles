{ pkgs, lib, ...}:

{
  # Install hyprlock
  home.packages = with pkgs; [
     hyprlock
  ];
  
  #link config file
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  
  # Link assets
  home.file.".config/hypr/hyprlock/assets" = {
     source = ./hyprlock/assets;
     recursive = true;
  };
}
