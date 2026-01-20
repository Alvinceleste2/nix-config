{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    home-manager
    gcc
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
