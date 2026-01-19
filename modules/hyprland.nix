{ config, pkgs, inputs, ... }:

{
  programs.kitty.enable = true;

  programs.hyprland = {
  	enable = true;
	package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  environment.systemPackages = with pkgs; [
  ];
}
