{ config, pkgs, ... }:

{
  imports = [
    ./core
    ./graphics
    ./profiles
    ./services
  ];
}
