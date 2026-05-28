{ config, pkgs, ... }:

{
  nix.settings.trusted-users = [ "alvinceleste" ];

  users = {
    users = {
      alvinceleste = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
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
}
