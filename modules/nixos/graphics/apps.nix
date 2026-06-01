{
  config,
  pkgs,
  lib,
  dir,
  desc,
  ...
}:

let
  cfg = lib.attrByPath dir { } config;
in
{
  options = lib.setAttrByPath dir {
    enable = lib.mkEnableOption desc;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
      firefox
      gnome-calculator
      kdePackages.dolphin
      fuzzel

      spotify
      signal-desktop
      discord
      pencil
      libreoffice

      jellyfin-desktop
    ];

    environment.sessionVariables = {
      TERMINAL = "kitty";
      BROWSER = "firefox";
      LAUNCHER = "fuzzel";
      FILEMANAGER = "dolphin";
      CALCULATOR = "calculator";
    };
  };
}
