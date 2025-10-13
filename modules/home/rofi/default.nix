{ pkgs, lib, ... }:
let
  rofiConfigDir = builtins.toString ./.;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.kitty}/bin/kitty";
  };

  # Copy rofi config files
  home.file.".config/rofi/style_1.rasi".source = "${rofiConfigDir}/style_1.rasi";
  home.file.".config/rofi/theme.rasi".source = "${rofiConfigDir}/theme.rasi";
  
  # Copy background image
  home.file.".config/rofi/background.png" = {
    source = "${rofiConfigDir}/background.png";
  };
  
  # Create cache directory and copy wallpaper for rofi
  home.activation.rofiWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p ~/.cache/hyde
    $DRY_RUN_CMD cp ${rofiConfigDir}/background.png ~/.cache/hyde/wall.thmb
    $DRY_RUN_CMD cp ${rofiConfigDir}/background.png ~/.cache/hyde/wall.blur
  '';
}