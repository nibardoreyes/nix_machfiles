{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # Optional: where to put config files or override settings
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      background_opacity = "0.7";
      scrollback_lines = 2000;
    };

  };
}

