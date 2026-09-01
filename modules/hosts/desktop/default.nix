{ self, inputs, ... }:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.desktopConfiguration
      self.modules.nixos.desktopHardware
      self.modules.nixos.desktopDisko
    ];
  };

  flake.modules.nixos.desktopDisko = {
    boot.initrd.luks.devices."cryptroot" = {
      device = "/dev/disk/by-label/luks";
      preLVM = true;
    };

    boot = {
      kernelParams = [
        "resume_offset=533760"
      ];
      resumeDevice = "/dev/disk/by-label/nixos";
    };
  };
}
