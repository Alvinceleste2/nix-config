{
	description = "NixOS Config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in
		{
			nixosConfigurations = {
				laptop = lib.nixosSystem {
					inherit system;
					specialArgs = { inherit inputs; };
					modules = [
						./hosts/laptop/configuration.nix
					];
				};
			};

			homeConfigurations = {
				alvinceleste = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./hosts/laptop/home.nix ];
				};
			};	
		};
}
