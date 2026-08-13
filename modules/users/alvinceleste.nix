{ self, ... }:
{
  flake.modules.nixos.alvinceleste =
    { pkgs, config, ... }:
    {
      # decrypt alvinceleste-password to /run/secrets-for-users/ so it can be used to create the user
      sops.secrets.alvinceleste-password.neededForUsers = true;
      users.mutableUsers = false; # required for password to be set via sops during system activation

      nix.settings.trusted-users = [ "alvinceleste" ];

      users = {
        users = {
          alvinceleste = {
            shell = pkgs.zsh;
            uid = 1000;
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets.alvinceleste-password.path;
            extraGroups = [
              "wheel"
              "users"
              "networkmanager"
            ];
            group = "alvinceleste";
          };
        };

        groups = {
          alvinceleste = {
            gid = 1000;
          };
        };
      };

      programs.zsh.enable = true;

      home-manager.users.alvinceleste = {
        imports = [
          self.modules.homeManager.alvinceleste
          self.modules.homeManager.sops

          self.modules.homeManager.git
          self.modules.homeManager.zsh
          self.modules.homeManager.ssh
          self.modules.homeManager.fuzzel
        ];

        sops.secrets."alvinceleste-github" = { };
      };
    };

  flake.modules.homeManager.alvinceleste = {
    home.username = "alvinceleste";
    home.homeDirectory = "/home/alvinceleste";
    home.stateVersion = "25.11";
    home.packages = [ ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
