{ config, pkgs, ... }:

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
  programs.git.enable = true;
}
