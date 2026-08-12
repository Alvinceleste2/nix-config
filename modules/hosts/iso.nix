{
  self,
  inputs,
  config,
  ...
}:
{
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      (
        { pkgs, modulesPath, ... }:
        {
          imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
        }
      )

      self.modules.nixos.isoConfiguration
    ];
  };

  flake.modules.nixos.isoConfiguration = {
    imports = [
      self.modules.nixos.core
      self.modules.nixos.alvinceleste
    ];

    nixpkgs.hostPlatform = "x86_64-linux";

    networking.hostName = "nixos-live";
    environment.etc."nixos".source = self;
    isoImage.isoName = "nixos-flake-${self.shortRev or "dirty"}.iso";

    system.stateVersion = "26.05";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.iso = config.flake.nixosConfigurations.iso.config.system.build.isoImage;
    };
}
