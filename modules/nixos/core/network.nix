{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.core.network;
in
{
  options.modules.core.network.enable = lib.mkEnableOption "enables core/network";

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
