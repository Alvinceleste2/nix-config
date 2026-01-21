{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "FantasqueSansM Nerd Font"];
    serif = [ "FantasqueSansM Nerd Font"];
    monospace = [ "FantasqueSansM Nerd Font"];
  };
}
