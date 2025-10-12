{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;  # Set as default editor
    viAlias = true;        # Create 'vi' alias
    vimAlias = true;       # Create 'vim' alias
   
  };
  
  # Symlink your Neovim config
  home.file.".config/nvim" = {
    source = ./.;  # Points to modules/home/nvim/nvim folder
    recursive = true;
  };
}
