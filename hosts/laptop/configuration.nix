{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules

    ../../core/fonts.nix
    ../../core/packages.nix
    ../../core/dev.nix
    ../../core/apps.nix
    ../../core/virtualization.nix

    ../../users/alvinceleste.nix

    ../../modules/hyprland.nix
    ../../modules/neovim.nix
    ../../modules/display-manager.nix
  ];

  modules.core.enable = true;

  networking.hostName = "laptop";

  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.firefox.enable = true;

  system.stateVersion = "25.11";

}
