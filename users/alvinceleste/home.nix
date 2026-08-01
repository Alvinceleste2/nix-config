{ config, pkgs, ... }:

{

  imports = [
    ../../modules/home
  ];

  home.username = "alvinceleste";
  home.homeDirectory = "/home/alvinceleste";
  home.stateVersion = "25.11";
  home.packages = [ ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  modules.home = {
    dunst.enable = true;
    git.enable = true;
    ssh = {
      enable = true;
      githubKeyPath = config.sops.secrets."alvinceleste-github".path;
    };
    zsh.enable = true;
    kitty.enable = true;
  };
}
