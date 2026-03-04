{
	description = "NixOS Config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

		in
		{
			nixosConfigurations = {
				laptop = nixpkgs.lib.nixosSystem {
					inherit system;

					modules = [
						./hosts/laptop/configuration.nix
					];
				};
			};
		};
}
