{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.core.system;
in
{
  options.modules.core.system.enable = lib.mkEnableOption "enables core/system";

  config = lib.mkIf cfg.enable {
    time.timeZone = "Europe/Madrid";
    console.keyMap = "es";
  };
}
