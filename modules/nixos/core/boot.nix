{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.core.boot;
in
{
  options.modules.core.boot.enable = lib.mkEnableOption "enables core/boot";

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
