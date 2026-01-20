{ pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix

      ../../core/boot.nix
      ../../core/fonts.nix
      ../../core/settings.nix
      ../../core/packages.nix

      ../home/alvinceleste/alvinceleste.nix

      ../../modules/hyprland.nix
      ../../modules/sddm.nix
    ];

  networking.hostName = "nixos";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.firefox.enable = true;

  system.stateVersion = "25.11";

}

