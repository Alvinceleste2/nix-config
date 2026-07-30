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

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      themeFile = "rose-pine";
      font = {
        name = "FantasqueSansM Nerd Font";
        size = 12;
      };

      settings = {
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";

        mouse_hide_wait = "2.0";
        cursor_shape = "underline";
        url_style = "dotted";

        confirm_os_window_close = 0;
        background_opacity = "1.0";
      };
    };

    home.packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
    ];
  };
}
