{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.services.tailscale;
in
{
  options.modules.services.tailscale.enable = lib.mkEnableOption "enables services/tailscale";

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
