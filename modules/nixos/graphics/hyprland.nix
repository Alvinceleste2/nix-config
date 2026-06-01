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
