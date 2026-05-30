{ config, pkgs, ... }:

{
  imports = [
    ./core
    ./graphics
    ./services
  ];
}
