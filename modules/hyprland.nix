{ config, pkgs, inputs, ... }:

{
	programs.hyprland = {
		enable = true;
		#package = inputs.hyprland.packages."${pkgs.system}".hyprland;
	};

	environment.systemPackages = with pkgs; [
  		hyprlock
		hyprpaper
		hypridle
  	];
}
