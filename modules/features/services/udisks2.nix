{
  flake.modules.nixos.udisks2 = {
    services.udisks2.enable = true;

    services.devmon.enable = true;
    services.gvfs.enable = true;
  };
}
