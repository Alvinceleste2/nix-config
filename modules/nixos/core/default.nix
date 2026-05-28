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
    modules.core.boot.enable = lib.mkDefault true;

    modules.core.garbage-collection.enable = lib.mkDefault true;
    modules.core.system.enable = lib.mkDefault true;
    modules.core.packages.enable = lib.mkDefault true;
    modules.core.network.enable = lib.mkDefault true;
  };
}
