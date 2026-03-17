{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.tailscale.enable = true;
}
