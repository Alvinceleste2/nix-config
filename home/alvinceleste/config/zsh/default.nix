{ config, pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			ls = "ls -l";
			l = "ls -lah --color";
			"cd.." = "cd ..";
		};
		history.size = 16000;
	};
}
