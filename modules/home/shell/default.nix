{ config, pkgs, ...}:
let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     ff = "fastfetch";
     ls = "eza -l --icons=always";
     la = "eza -la --icons=always";
     lt = "eza --tree --icons=always";
   };
in
{
  programs.bash = {
     enable = true;
     shellAliases = myAliases;
     bashrcExtra = ''
       # Import colorscheme from 'wal' asynchronously
       (cat ~/.cache/wal/sequences &)
     '';
  };
  
  programs.zsh = {
     enable = true;
     shellAliases = myAliases;
     initContent = ''  # Changed from initExtra
       # Import colorscheme from 'wal' asynchronously
       (cat ~/.cache/wal/sequences &)
     '';
  };  
}
