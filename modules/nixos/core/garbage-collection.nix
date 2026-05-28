{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.core.garbage-collection;
in
{
  options.modules.core.garbage-collection.enable =
    lib.mkEnableOption "enables core/garbage-collection";

  config = lib.mkIf cfg.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nix.settings.auto-optimise-store = true;
  };
}
