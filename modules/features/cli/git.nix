{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Álvaro Grande";
          email = "github.hvgyj15x@alvinceleste.eu";
        };

        alias.st = "status";
        core.editor = "nvim";
        pull.rebase = true;
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
    };

  };
}
