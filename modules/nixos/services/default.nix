{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.services;
in
{
  imports = [

    ./tailscale.nix
  ];

  options.modules.services.enable = lib.mkEnableOption "enables services";

  config = lib.mkIf cfg.enable {

    modules.services.tailscale.enable = lib.mkDefault true;
  };
}
