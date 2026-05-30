{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.core;
in
{
  imports = [
    ./boot.nix

    ./garbage-collection.nix
    ./system.nix
    ./packages.nix
    ./network.nix
  ];

  options.modules.core.enable = lib.mkEnableOption "enables core";

  config = lib.mkIf cfg.enable {
    modules.core = {
      boot.enable = lib.mkDefault true;

      garbage-collection.enable = lib.mkDefault true;
      system.enable = lib.mkDefault true;
      packages.enable = lib.mkDefault true;
      network.enable = lib.mkDefault true;
    };
  };
}
