{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.graphics.display-manager;
in
{
  options.modules.graphics.display-manager.enable =
    lib.mkEnableOption "enables graphics/display-manager";

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
