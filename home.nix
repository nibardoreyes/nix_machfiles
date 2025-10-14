{ config, pkgs, ... }:
{ 
   imports = [
      ./modules/home/shell
      ./modules/home/kitty
      ./modules/home/hyprland
      ./modules/home/hyprlock
      ./modules/home/waybar
      ./modules/home/fastfetch
      ./modules/home/starship
      #./modules/home/matugen
      ./modules/home/nvim
      ./modules/home/swaync
      ./modules/home/wofi
      ./modules/home/rofi
      ./modules/home/tmux
   ];
   
  home.username = "nibardo";
  home.homeDirectory = "/home/nibardo";
  home.stateVersion = "25.05";

  # Allow unfree packages in home-manager
  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [  
    # Development utilities
    postman
    insomnia
    docker-compose
    postgresql
    sqlite
  ];
  
  home.file = {
  };
  
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  
  programs.home-manager.enable = true;
  programs.starship.enable = true;
  
  # Enable direnv for automatic dev environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  
  gtk = {
    enable = true;
    
    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };
    
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
  
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}