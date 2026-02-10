{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Madrid";
  console.keyMap = "es";

  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
}
