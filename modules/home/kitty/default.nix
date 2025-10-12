{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # Tell Home Manager to use your own config file instead of generating one
    extraConfig = builtins.readFile ./kitty.conf;
  };
}

