{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim

    # programming
    gcc
  ];
}
