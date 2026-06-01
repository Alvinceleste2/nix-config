{
  config,
  pkgs,
  lib,
  dir,
  desc,
  ...
}:

let
  cfg = lib.attrByPath dir { } config;
in
{
  options = lib.setAttrByPath dir {
    enable = lib.mkEnableOption desc;
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;

    # needed for eduroam
    environment.systemPackages = with pkgs; [
      networkmanagerapplet
    ];
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
