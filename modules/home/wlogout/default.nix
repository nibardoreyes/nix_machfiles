{ config, pkgs, ... }:
let
  # Define your style variables
  fntSize = "16";
  BtnCol = "white";
  active_rad = "12";
  button_rad = "8";
in
{
  # Install wlogout and hyprlock
  home.packages = with pkgs; [
    wlogout
    hyprlock
  ];
  
  # Copy icons
  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
  
  # Use layout_1 as the default layout
  home.file.".config/wlogout/layout".source = ./layout_1;
  
  # Process style with variables substituted
  home.file.".config/wlogout/style.css".text = ''
    * {
        background-image: none;
        font-size: ${fntSize}px;
    }
    
    window {
        background-color: rgba(0, 0, 0, 0.5);
    }
    
    button {
        color: ${BtnCol};
        background-color: rgba(30, 30, 46, 0.9);
        outline-style: none;
        border: none;
        border-width: 0px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-radius: ${button_rad}px;
        box-shadow: none;
        text-shadow: none;
        min-width: 200px;
        min-height: 200px;
        margin: 0px;
    }
    
    button:focus {
        background-color: rgba(88, 91, 112, 0.9);
        background-size: 30%;
    }
    
    button:hover {
        background-color: rgba(116, 199, 236, 0.5);
        background-size: 35%;
        border-radius: ${active_rad}px;
        transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
    }
    
    #lock {
        background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/lock_${BtnCol}.png"));
    }
    
    #logout {
        background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/logout_${BtnCol}.png"));
    }
    
    #suspend {
        background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/suspend_${BtnCol}.png"));
    }
    
    #shutdown {
        background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/shutdown_${BtnCol}.png"));
    }
    
    #hibernate {
        background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/hibernate_${BtnCol}.png"));
    }
    
    #reboot {
        background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/reboot_${BtnCol}.png"));
    }
  '';
}
