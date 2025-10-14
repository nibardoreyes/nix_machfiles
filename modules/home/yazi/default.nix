{ config, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  
  home.file.".config/yazi/yazi.toml".text = ''
    [opener]
    edit = [
      { run = 'nvim "$@"', block = true }
    ]
    
    video = [
      { run = 'mpv "$@"', orphan = true, for = "unix" }
    ]
    
    image = [
      { run = 'shotwell "$@"', orphan = true, for = "unix" }
    ]

    [open]
    rules = [
      { mime = "text/*", use = "edit" },
      { mime = "application/json", use = "edit" },
      { mime = "*/xml", use = "edit" },
      
      { mime = "video/*", use = "video" },
      { mime = "audio/*", use = "video" },
      
      { mime = "image/*", use = "image" },
    ]
  '';
  
  # Make sure mpv and shotwell are installed
  home.packages = with pkgs; [
    mpv
    shotwell
  ];
  
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
