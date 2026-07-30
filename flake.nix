{
  description = "NixOS Config";

  inputs = {
    # Official NixOS Package Sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My secrets
    nix-secrets = {
      url = "git+ssh://git@github.com/Alvinceleste2/nix-secrets.git";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      sops-nix,
      home-manager,
      nix-secrets,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/laptop/configuration.nix
          ];
        };
      };
    };
}
