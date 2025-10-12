{ pkgs, lib, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.libsForQt5.sddm;  # Use Qt5 version explicitly
    sugarCandyNix = {
      enable = true;
      settings = {
        Background = lib.cleanSource ./Backgrounds/pywal.jpg;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];
}
