{
  flake.modules.homeManager.zsh =
    { lib, ... }:
    {
      programs.zsh = {
        enable = true;

        enableCompletion = true;
        # syntaxHighlighting.enable = true;

        history = {
          size = 16000;
          save = 16000;
          path = "$HOME/.zsh_history";
        };

        shellAliases = {
          ls = "ls -lah --color";
          l = "ls -lah --color";
          mosh = "mosh --no-init";
          "cd.." = "cd ..";
          # nvim-new = "NVIM_APPNAME=nvim-new nvim";
        };

        initContent = lib.mkMerge [
          # Antes de compinit
          (lib.mkOrder 550 ''
            PROMPT="%B%F{red}%(?..%? )%f%b%B%F{blue}%n%f%b@%m %B%40<..<%~%<< %b%# "
          '')
          # Al final
          (lib.mkOrder 1000 ''
            setopt extendedglob
            unsetopt beep

            zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
            zstyle ':completion:*' expand prefix suffix
            zstyle ':completion:*' completer _expand_alias _complete _approximate
            zstyle ':completion:*' special-dirs true

            autoload -Uz history-search-end
            zle -N history-beginning-search-backward-end history-search-end
            zle -N history-beginning-search-forward-end history-search-end
            bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
            bindkey "$terminfo[kcud1]" history-beginning-search-forward-end

            WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
            WORDCHARS=''${WORDCHARS:s@/@}
          '')
        ];
      };
    };
}
