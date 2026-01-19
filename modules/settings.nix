{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Madrid"; 

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  console.keyMap = "es";
}
