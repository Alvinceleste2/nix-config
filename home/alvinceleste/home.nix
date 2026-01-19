{ config, pkgs, ... }:

{
	home.username = "alvinceleste";
	home.homeDirectory = "/home/alvinceleste";
	home.stateVersion = "25.11";

	imports = [
		./config
	];
}
