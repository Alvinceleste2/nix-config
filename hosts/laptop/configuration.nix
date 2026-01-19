{ pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix

      ../../users/alvinceleste.nix

      ../../modules/packages.nix
      ../../modules/settings.nix
      ../../modules/boot.nix

      ../../modules/hyprland.nix
      ../../modules/sddm.nix
    ];

  networking.hostName = "nixos";

  system.stateVersion = "25.11";

}

