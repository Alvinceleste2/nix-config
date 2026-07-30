{
  config,
  pkgs,
  lib,
  inputs,
  dir,
  desc,
  ...
}:

let
  cfg = lib.attrByPath dir { } config;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options = lib.setAttrByPath dir {
    enable = lib.mkEnableOption desc;
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "backup";

      extraSpecialArgs = { inherit inputs; };

      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
}
