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
    services.displayManager.ly = {
      enable = true;

      settings = {
        animate = true;
        animation = 2;

        save = true;
        load = true;
        default_desktop = "Hyprland";
      };
    };
  };
}
