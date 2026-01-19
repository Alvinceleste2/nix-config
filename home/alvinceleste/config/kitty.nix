{ config, pkgs, ... }:

{
	programs.kitty = {
		enable = true;

		font = {
			name = "Fantasque Sans Mono";
			size = 11;
		};
	};
}
