{ self, inputs, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptopConfiguration
      self.modules.nixos.laptopHardware
    ];
  };

  flake.modules.nixos.laptopConfiguration = {
    imports = [

      self.modules.nixos.core
      self.modules.nixos.hyprland
      self.modules.nixos.ssh

      self.modules.nixos.alvinceleste
    ];

    networking.hostName = "laptop";

    system.stateVersion = "25.11";
  };

  flake.modules.nixos.laptopHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/fb8fc620-448f-42a9-bdf5-c4da33970999";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/78FB-F373";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
