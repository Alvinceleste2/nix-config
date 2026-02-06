{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    stow
    htop
    neofetch
    curl
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
