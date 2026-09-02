{ self, inputs, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptopConfiguration
      self.modules.nixos.laptopHardware
      # self.modules.nixos.laptopDisko

      inputs.disko.nixosModules.disko
    ];
  };

  flake.modules.nixos.laptopDisko = {
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
