{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    firefox
    fuzzel
    kdePackages.dolphin
    gnome-calculator

    spotify
    signal-desktop
    discord
    pencil
    libreoffice

    jellyfin-desktop
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
    LAUNCHER = "fuzzel";
    FILEMANAGER = "dolphin";
    CALCULATOR = "gnome-calculator";
  };
}
