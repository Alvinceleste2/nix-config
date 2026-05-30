{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules

    ../../users/alvinceleste.nix
  ];

  modules = {
    core.enable = true;
    graphics = {
      enable = true;
      virtualization.enable = false;
    };
    profiles = {
      dev.enable = true;
    };
    services = {
      tailscale.enable = true;
    };
  };

  networking.hostName = "laptop";

  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "25.11";
}
