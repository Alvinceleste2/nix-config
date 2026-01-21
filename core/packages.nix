{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    stow
    gcc
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
