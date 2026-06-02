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
      network.enable = true;
      packages.enable = true;
      ssh.enable = true;
      system.enable = true;
    };

    graphics = {
      desktop-environments.hyprland.enable = true;
      display-manager = {
        enable = true;
        dm = "greetd";
      };
      fonts.enable = true;
    };

    hardware = {
      audio.enable = true;
    };

    profiles = {
      dev.enable = true;
    };

    services = {
      tailscale.enable = true;
      garbage-collection.enable = true;
    };
  };

  networking.hostName = "laptop";

  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "25.11";
}
