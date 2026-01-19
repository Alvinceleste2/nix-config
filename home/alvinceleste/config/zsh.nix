{ config, pkgs, ... }:

{
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
}
