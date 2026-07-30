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
    fonts.packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
    ];

    fonts.fontconfig.defaultFonts = {
      sansSerif = [ "FantasqueSansM Nerd Font" ];
      serif = [ "FantasqueSansM Nerd Font" ];
      monospace = [ "FantasqueSansM Nerd Font Mono" ];
    };

    fonts.fontconfig.enable = true;
  };
}
