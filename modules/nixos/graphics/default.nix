{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.graphics;
in
{
  imports = [
    ./apps.nix
    ./audio.nix

    ./display-manager.nix
    ./fonts.nix
    ./hyprland.nix
    ./virtualization.nix
  ];

  options.modules.graphics.enable = lib.mkEnableOption "enables graphics";

  config = lib.mkIf cfg.enable {
    modules.graphics = {
      apps.enable = lib.mkDefault true;
      audio.enable = lib.mkDefault true;

      display-manager.enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      virtualization.enable = lib.mkDefault true;
    };
  };
}
