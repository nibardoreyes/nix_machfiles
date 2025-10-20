{ config, pkgs, ...}:
let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     ff = "fastfetch";
     ls = "eza -l --icons=always";
     la = "eza -la --icons=always";
     lt = "eza --tree --icons=always";
     # Tmux aliases
     tt = "~/.scripts/startup_tmux.sh";
     ts = "tmux kill-session";
     tsv = "tmux kill-server";
     # Gocrypt
    vault_open = "gocryptfs ~/.vault/encrypted_vault ~/.vault/open_vault";
    vault_close= "fusermount -u ~/.vault/open_vault";
    # Gocrupt ssd
    ssd_vault_open= "gocryptfs /run/media/nibardo/X1/.vault/encrypted_vault /run/media/nibardo/X1/.vault/open_vault";
    ssd_vault_close= "fusermount -u /run/media/nibardo/X1/.vault/open_vault";

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
     enableCompletion = true;
     autosuggestion.enable = true;  # This enables zsh-autosuggestions
     
     # Session variables
     sessionVariables = {
       PATH = "$HOME/.scripts:$PATH";
       EDITOR = "nvim";           # Add this
       VISUAL = "nvim";           # Add this too
     };
     
     initContent = ''
       # Import colorscheme from 'wal' asynchronously
       (cat ~/.cache/wal/sequences &)

      # Case-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
       
       # Ctrl+F for fuzzy directory navigation
       bindkey -s '^f' 'source ~/.scripts/fuzzy_dir.sh\n'
       
       # Ctrl+R for fzf history search
       autoload -Uz fzf-history-widget
       zle -N fzf-history-widget
       bindkey '^R' fzf-history-widget
       
       # Initialize zoxide
       eval "$(zoxide init zsh)"
       
  # MPD update and launch function
  function m() {
      echo "Updating MPD database..."
      mpc update
      echo "Launching rmpc..."
      rmpc
  }

    # Yazi cd helper
    function e() {
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
