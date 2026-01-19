{ config, pkgs, ... }:

{
	imports = [
		./git
		./hyprland
		./kitty
		./neovim
		./zsh
	];
}
