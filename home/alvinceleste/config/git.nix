{ config, pkgs, ...}:

{
	programs.git = {
		enable = true;
		settings.user = {
			name = "Alvinceleste2";
			email = "github.hvgyj15x@alvinceleste.eu";
			init.defaultBranch = "main";
			pull.rebase = true;
		};
	};
}
