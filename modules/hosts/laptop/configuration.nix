{ self, ... }:
{
  flake.modules.nixos.laptopConfiguration = {
    imports = [
      self.modules.nixos.core
      self.modules.nixos.lanzaboote

      self.modules.nixos.alvinceleste
      self.modules.nixos.ssh

      self.modules.nixos.hyprlandLaptop

      self.modules.nixos.dev
      self.modules.nixos.virtualization
    ];

    networking.hostName = "laptop";

    system.stateVersion = "25.11";
  };
}
