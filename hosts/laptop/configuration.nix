{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules

    ../../core/packages.nix
    ../../core/dev.nix

    ../../users/alvinceleste.nix

    ../../modules/neovim.nix
  ];

  modules = {
    core.enable = true;
    graphics = {
      enable = true;
      virtualization.enable = false;
    };
    services = {
      tailscale.enable = true;
    };
  };

  networking.hostName = "laptop";

  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  programs.firefox.enable = true;

  system.stateVersion = "25.11";
}
