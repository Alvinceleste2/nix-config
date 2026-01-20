{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    htop
    neofetch
    home-manager
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
