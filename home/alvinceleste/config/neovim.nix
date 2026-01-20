{ config, pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink /home/alvinceleste/.dotfiles/nvim/.config/nvim;
}
