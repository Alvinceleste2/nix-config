{ self, ... }:
{
  flake.modules.nixos.laptopConfiguration = {
    imports = [
      self.modules.nixos.core
      self.modules.nixos.lanzaboote

      self.modules.nixos.hyprlandLaptop

      self.modules.nixos.ssh
      self.modules.nixos.virtualization

      self.modules.nixos.alvinceleste
    ];

    networking.hostName = "laptop";

    system.stateVersion = "25.11";
  };
}
