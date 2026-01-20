{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-nerd-sans-mono
  ];
}
