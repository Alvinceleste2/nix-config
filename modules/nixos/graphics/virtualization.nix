{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.graphics.virtualization;
in
{
  options.modules.graphics.virtualization.enable =
    lib.mkEnableOption "enables graphics/virtualization";

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "alvinceleste" ];
  };
}
