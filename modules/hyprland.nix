{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

 #xdg.portal = {
 #  enable = true;
 #  extraPortals = with pkgs; [
 #    xdg-desktop-portal-gtk
 #    xdg-desktop-portal-hyprland
 #  ];
 #  config.common.default = "*";
 #};

  environment.systemPackages = with pkgs; [
  ];
}
