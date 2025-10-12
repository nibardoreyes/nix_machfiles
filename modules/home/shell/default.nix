{ config, pkgs, ...}:
let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     ff = "fastfetch";
   };
in
{
  programs.bash = {
     enable = true;
     shellAliases = myAliases;  
  };
  
  programs.zsh = {
     enable = true;
     shellAliases = myAliases;
  };  

}
