{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    stow
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
