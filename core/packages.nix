{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    stow
    htop
    neofetch
    curl
    zip
    unzip
  ];

  programs.zsh.enable = true;

  programs.git.enable = true;

  programs.nix-ld.enable = true;
}
