{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Álvaro Grande";
          email = "git.b5pphvyu@alvinceleste.eu";
        };

        alias.st = "status";
        core.editor = "nvim";
        pull.rebase = true;
        push.autoSetupRemote = true;
        init.defaultBranch = "main";

        safe.directory = "/etc/nixos";
      };
    };
  };
}
