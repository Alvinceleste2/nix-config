{ config, pkgs, ... }:

{
  users.users.alvinceleste = {
    isNormalUser = true;
    extraGroups = [ "wheel" "users" ];
  };

  users.defaultUserShell = pkgs.zsh;
}
