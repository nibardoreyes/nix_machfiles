# configuration.nix
{ config, pkgs, lib, ... }:
{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
    ];
  
  # --- Bootloader ---
boot.loader = {
  systemd-boot.enable = lib.mkForce true;
  efi.canTouchEfiVariables = true;
  grub.enable = lib.mkForce false;
  grub.device = lib.mkForce "nodev";
};
  
  # --- Shells ---
  environment.shells = with pkgs; [ zsh fish ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  
  # --- Hostname & networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # --- Locale & Timezone ---
  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # --- X11 / Display manager / Desktop ---
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  services.displayManager.defaultSession = "hyprland";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # --- Sound ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # --- Users ---
  users.users.nibardo = {
    isNormalUser = true;
    description = "Nibardo";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
  
  # --- Programs ---
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  
  # --- Packages --- (ONLY ONE DEFINITION!)
  environment.systemPackages = with pkgs; [
    vim
    neovim
    btop
    wget
    gedit
    hyprland
    kitty
    waybar
    rofi
    nwg-look
    fastfetch
    git
    bat
    yazi
    swww
    lazygit
    # Add any packages from your other list here
  ];
  
  # --- Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  
  # --- Nix settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  # --- System state version ---
  system.stateVersion = "25.05";
}
