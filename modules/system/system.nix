{ config, pkgs, sddm-sugar-candy-nix, ... }:

{
  imports = [
    ./sddm
  ];

  # Apply the overlay for the SDDM theme
  nixpkgs.overlays = [ sddm-sugar-candy-nix.overlays.default ];

}
