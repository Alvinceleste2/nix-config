{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    home-manager
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;
}
