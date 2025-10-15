{ config, pkgs, ...}:
let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     ff = "fastfetch";
     ls = "eza -l --icons=always";
     la = "eza -la --icons=always";
     lt = "eza --tree --icons=always";
     e = "yazi";
     # Tmux aliases
     tt = "~/.scripts/startup_tmux.sh";
     ts = "tmux kill-session";
     tsv = "tmux kill-server";
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
     
     # Session variables
     sessionVariables = {
       PATH = "$HOME/.scripts:$PATH";
       EDITOR = "nvim";           # Add this
       VISUAL = "nvim";           # Add this too
     };
     
     initContent = ''
       # Import colorscheme from 'wal' asynchronously
       (cat ~/.cache/wal/sequences &)
       
       # Ctrl+F for fuzzy directory navigation
       bindkey -s '^f' 'source ~/.scripts/fuzzy_dir.sh\n'
       
       # Ctrl+R for fzf history search
       autoload -Uz fzf-history-widget
       zle -N fzf-history-widget
       bindkey '^R' fzf-history-widget
       
       # Initialize zoxide
       eval "$(zoxide init zsh)"
       
       # Dev environment templates
       newpy() {
         cp ~/nixos_machfiles/templates/python-flake.nix ./flake.nix
         echo "use flake" > .envrc
         direnv allow
         echo "✨ Python project initialized!"
       }
  # MPD update and launch function
  function m() {
      echo "Updating MPD database..."
      mpc update
      echo "Launching rmpc..."
      rmpc
  }

    # Yazi cd helper
    function y() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$tmp"
      local cwd
      IFS= read -r cwd < "$tmp"
      [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
      rm -f -- "$tmp"
    }
     '';
  };  
  
programs.fzf.enable = true;
}
