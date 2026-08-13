{ self, ... }:
{
  flake.modules.nixos.core = {
    imports = [
      self.modules.nixos.boot
      self.modules.nixos.garbage-collection
      self.modules.nixos.home-manager
      self.modules.nixos.locale
      self.modules.nixos.network
      self.modules.nixos.packages
      self.modules.nixos.sops
    ];
  };
}
