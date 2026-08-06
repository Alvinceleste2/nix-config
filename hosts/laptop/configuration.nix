{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos

    ../../users/alvinceleste
  ];

  modules.nixos = {
    core = {
      boot.enable = true;
      home-manager.enable = true;
      network.enable = true;
      openssh.enable = true;
      packages.enable = true;
      sops.enable = true;
      system.enable = true;
    };

    graphics = {
      hyprland.enable = true;
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
