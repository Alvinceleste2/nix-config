{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim

    # config
    tree-sitter
    nodejs_24

    # programming
    gcc
  ];
}
