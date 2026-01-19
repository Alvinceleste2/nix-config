{ config, pkgs, ... }:

{
  users.users.alvinceleste = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    	# tree
    ];
  };

  users.defaultUserShell = pkgs.zsh;
}
