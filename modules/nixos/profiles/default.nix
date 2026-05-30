{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.profiles;
in
{
  imports = [

    ./dev.nix
  ];

  options.modules.profiles.enable = lib.mkEnableOption "enables profiles";

  config = lib.mkIf cfg.enable {
    modules.profiles = {

      dev.enable = lib.mkDefault true;
    };
  };
}
