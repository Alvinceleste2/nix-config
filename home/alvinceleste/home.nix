{ config, pkgs, ... }:

{
	home.username = "alvinceleste";
	home.homeDirectory = "/home/alvinceleste";
	home.stateVersion = "25.11";

	imports = [
		./config/kitty.nix
		./config/hyprland.nix
		./config/zsh.nix
		./config/neovim.nix
		./config/git.nix
	];
}
