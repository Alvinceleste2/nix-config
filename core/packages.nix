{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    stow
    htop
    neofetch
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
