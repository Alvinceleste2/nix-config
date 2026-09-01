{ self, ... }:
{
  flake.modules.nixos.desktopConfiguration = {
    imports = [
      self.modules.nixos.core
      self.modules.nixos.lanzaboote

      self.modules.nixos.hyprlandDesktop

      self.modules.nixos.ssh
      self.modules.nixos.virtualization

      self.modules.nixos.alvinceleste
    ];

    networking.hostName = "desktop";

    system.stateVersion = "26.05";
  };
}
