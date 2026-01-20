{ config, pkgs, ... }:

{
	home.username = "alvinceleste";
	home.homeDirectory = "/home/alvinceleste";
	home.stateVersion = "25.11";

  # NIXOS CONFIGS #

	programs.git = {
		enable = true;
		settings.user = {
			name = "Alvinceleste2";
			email = "github.hvgyj15x@alvinceleste.eu";
			init.defaultBranch = "main";
			pull.rebase = true;
		};
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			ls = "ls -lah --color";
			l = "ls -lah --color";
			"cd.." = "cd ..";
		};
		history.size = 16000;

		initExtra = ''
			autoload -Uz promptinit
			promptinit
			export PS1="%{$(tput setaf 216)%}%n%{$(tput setaf 220)%}@%{$(tput setaf 222)%}%m %{$(tput setaf 229)%}%B%60<..<%~%<< %{$(tput sgr0)%}# "
		'';
	};

  # CUSTOM DOTFILES #

	home.file.".config/hypr/".source = config.lib.file.mkOutOfStoreSymlink /home/alvinceleste/nix-config/dotfiles/hyprland-laptop/.config/hypr;
	home.file.".config/waybar/".source = config.lib.file.mkOutOfStoreSymlink /home/alvinceleste/nix-config/dotfiles/waybar-laptop/.config/waybar;
	home.file.".config/kitty/".source = config.lib.file.mkOutOfStoreSymlink /home/alvinceleste/nix-config/dotfiles/kitty/.config/kitty;
	home.file.".config/fuzzel/".source = config.lib.file.mkOutOfStoreSymlink /home/alvinceleste/nix-config/dotfiles/fuzzel/.config/kitty;

	home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /home/alvinceleste/nix-config/dotfiles/nvim/.config/nvim;

  # PACKAGES #
  home.packages = [
    pkgs.kitty
  ];
}
