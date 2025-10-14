{ pkgs, lib, ... }:
let
  tmuxConfigDir = builtins.toString ./.;
in
{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = builtins.readFile "${tmuxConfigDir}/tmux.conf";
  };

  # Copy additional tmux config files (not tmux.conf - that's handled by programs.tmux)
  home.file.".config/tmux/macos.conf".source = "${tmuxConfigDir}/macos.conf";
  home.file.".config/tmux/statusline.conf".source = "${tmuxConfigDir}/statusline.conf";
  home.file.".config/tmux/utility.conf".source = "${tmuxConfigDir}/utility.conf";
  home.file.".config/tmux/tmux-nerd-font-window-name.yml".source = "${tmuxConfigDir}/tmux-nerd-font-window-name.yml";
}