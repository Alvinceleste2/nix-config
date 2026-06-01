{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules

    ../../users/alvinceleste.nix
  ];

  modules.nixos = {
    core = {
      boot.enable = true;
      garbage-collection.enable = true;
      network.enable = true;
      packages.enable = true;
      system.enable = true;
    };

    graphics = {
      desktop-environments.hyprland.enable = true;
      audio.enable = true;
      display-manager = {
        enable = true;
        dm = "greetd";
      };
      fonts.enable = true;
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
