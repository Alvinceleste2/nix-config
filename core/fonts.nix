{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "FantasqueSansM Nerd Font Mono"];
    serif = [ "FantasqueSansM Nerd Font Mono"];
    monospace = [ "FantasqueSansM Nerd Font Mono"];
  };
}
