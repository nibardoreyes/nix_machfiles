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
  services.xserver.desktopManager.gnome.enable = true;
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
    tmux
    bat
    yazi
    swww
    lazygit
    eza
    pywal
    imagemagick
    #For thunar
    xfce.thunar
    xfce.thunar-volman  # Removable device management
    xfce.thunar-archive-plugin  # Archive support
    xfce.thunar-media-tags-plugin  # Media file tags
    # GTK themes
    adwaita-icon-theme  # Default GNOME icons
    papirus-icon-theme  # Popular icon theme
    arc-theme
    dracula-theme
    catppuccin-gtk
    nwg-look
    nordic
    orchis-theme
    kora-icon-theme
    bibata-cursors
    fzf
    vscode
    brightnessctl
    mpv
    tree
    wofi
    obsidian
    swaynotificationcenter
    gvfs
    libnotify
    wlogout
    # Volume control
    pavucontrol      # GUI volume control
    playerctl        # Media player control (you're already using this)
    # Bluetooth
    bluez            # Bluetooth stack
    bluez-tools      # Bluetooth utilities
    blueman          # Bluetooth GUI manager
    gcc
    gnumake
    cmake
    pkg-config
    # General development
    direnv  # Auto-load dev environments
    nix-direnv  # Better direnv for Nix
  ];

  # Enable direnv for automatic dev shells
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  
# Enable Thunar services for better integration
programs.thunar = {
  enable = true;
  plugins = with pkgs.xfce; [
    thunar-volman
    thunar-archive-plugin
    thunar-media-tags-plugin
  ];
};

# Enable Bluetooth
hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;  # Power on Bluetooth on boot
  settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;  # For better device support
    };
  };
};

# Bluetooth GUI service
services.blueman.enable = true;

# Enable thumbnail support
services.tumbler.enable = true;

# Enable GVFS for trash, network shares, etc.
services.gvfs.enable = true;  
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
