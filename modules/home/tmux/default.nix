{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  home.file.".config/tmux" ={
    source = ./.;
    recursive = true;
  };
} 
