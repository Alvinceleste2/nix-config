{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    spotify
    signal-desktop
    discord
  ];
}
