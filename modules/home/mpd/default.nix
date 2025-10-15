{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ mpd ];

  # Symlink the entire mpd directory
  home.file.".config/mpd".source = ./.;
}
