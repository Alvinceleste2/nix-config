{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Madrid";
  console.keyMap = "es";
}
