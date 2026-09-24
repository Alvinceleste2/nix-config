{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      listenAddresses = [ ];
    };

    programs.ssh.startAgent = true;
  };

  flake.modules.homeManager.ssh =
    { config, lib, ... }:
    {
      options.myHome.services.ssh = {
        githubKeyPath = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = "${config.home.homeDirectory}/.ssh/${config.home.username}";
          description = "Route of private SSH key for GitHub";
        };

        gitlabKeyPath = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = "${config.home.homeDirectory}/.ssh/${config.home.username}";
          description = "Route of private SSH key for GitLab";
        };
      };

      config =
        let
          cfg = config.myHome.services.ssh;
        in
        {
          programs.ssh = {
            enable = true;
            enableDefaultConfig = false;

            matchBlocks = {
              "github.com" = lib.mkIf (cfg.githubKeyPath != null) {
                hostname = "github.com";
                user = "git";
                identityFile = cfg.githubKeyPath;
                identitiesOnly = true;
              };

              "gitlab.com" = lib.mkIf (cfg.gitlabKeyPath != null) {
                hostname = "gitlab.com";
                user = "git";
                identityFile = cfg.gitlabKeyPath;
                identitiesOnly = true;
              };
            };
          };
        };
    };
}
