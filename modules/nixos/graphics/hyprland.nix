{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.graphics.hyprland;
in
{
  options.modules.graphics.hyprland.enable = lib.mkEnableOption "enables graphics/hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hyprlock
      hypridle
      hyprpaper
      hyprpicker
      waybar
      cliphist
      wl-clipboard
      grim
      slurp
      jq
      dunst
      rose-pine-icon-theme
      rose-pine-gtk-theme
      bibata-cursors

      brightnessctl
    ];
  };
}
