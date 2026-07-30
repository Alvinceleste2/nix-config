{ config, pkgs, ... }:

{

  imports = [
    ../../modules/home
  ];

  home.username = "alvinceleste";
  home.homeDirectory = "/home/alvinceleste";
  home.stateVersion = "25.11";
  home.packages = [ ];

  modules.home = {
    git.enable = true;
    ssh = {
      enable = true;
      githubKeyPath = config.sops.secrets."alvinceleste-github".path;
    };
    zsh.enable = true;
  };
}
