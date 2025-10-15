{ config, pkgs, ... }: {
  imports = [ ./sddm-theme.nix ];

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "Sugar-Candy";
}
