{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    neovim
    wget
    htop
    neofetch
  ];
}
