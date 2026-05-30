{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.graphics.fonts;
in
{
  options.modules.graphics.fonts.enable = lib.mkEnableOption "enables graphics/audio";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
    ];

    fonts.fontconfig.defaultFonts = {
      sansSerif = [ "FantasqueSansM Nerd Font" ];
      serif = [ "FantasqueSansM Nerd Font" ];
      monospace = [ "FantasqueSansM Nerd Font Mono" ];
    };
  };
}
