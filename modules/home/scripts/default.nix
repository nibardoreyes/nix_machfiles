{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
    fzf
    zoxide
  ];

  home.file.".scripts/fuzzy_dir.sh" = {
    source = ./.scripts/fuzzy_dir.sh;
    executable = true;
  };

  home.file.".scripts/ide" = {
    source = ./.scripts/ide;
    executable = true;
  };

  home.file.".scripts/startup_tmux.sh" = {
    source = ./.scripts/startup_tmux.sh;
    executable = true;
  };
}
