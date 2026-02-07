{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix

      ../../core/boot.nix
      ../../core/fonts.nix
      ../../core/settings.nix
      ../../core/packages.nix
      ../../core/network.nix
      ../../core/dev.nix
      ../../core/apps.nix
      ../../core/virtualization.nix

      ../../users/alvinceleste.nix

      ../../modules/hyprland.nix
      ../../modules/neovim.nix
      ../../modules/display-manager.nix
    ];

  networking.hostName = "laptop";

  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.firefox.enable = true;

  system.stateVersion = "25.11";

}

