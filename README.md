# ============================================
# Weekly Update Routine
# ============================================

# Step 1: Update Dependencies
# ---------------------------
# Updates flake.lock to use latest versions of nixpkgs and other inputs
# This fetches the newest package versions available
nix flake update

# Step 2: Apply System Updates
# ---------------------------
# Rebuilds your system configuration with the new package versions
# This updates system-level packages, services, and kernel
sudo nixos-rebuild switch --flake . --impure

# Step 3: Apply User Updates
# ---------------------------
# Rebuilds your Home Manager configuration
# This updates user applications, dotfiles, and themes
home-manager switch --flake .

# Step 4: Clean Up Old Versions
# ---------------------------
# Removes system generations (snapshots) older than 14 days
# Frees up disk space - keeps only recent configurations for rollback
sudo nix-collect-garbage --delete-older-than 14d

# Optional: Optimize Nix Store
# ---------------------------
# Deduplicates identical files in /nix/store to save more space
# nix-store --optimize




## Initial home-manager setup command
sudo nix run nixpkgs#home-manager -- init --switch
