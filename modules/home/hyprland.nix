{
  config,
  lib,
  pkgs,
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

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {

        wayland.windowManager.hyprland = {
          enable = true;
        };

        modules.home = {
          kitty.enable = true;
          fuzzel.enable = true;
          dunst.enable = true;
        };

        home.packages = with pkgs; [
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
          rose-pine-icon-theme
          rose-pine-gtk-theme
          bibata-cursors

          brightnessctl
        ];
      }

      (import ./_apps.nix { inherit pkgs; })
    ]
  );
}
