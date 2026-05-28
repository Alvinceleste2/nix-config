{ config, pkgs, ... }:

{
  imports = [
    ./core

    ./services
  ];
}
