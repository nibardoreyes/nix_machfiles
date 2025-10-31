{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    # Read your config from the separate file
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  #home.file.".config/hypr/keyboard.conf".source = ./keyboard.conf;
}

