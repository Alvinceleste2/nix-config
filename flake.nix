{
	description = "NixOS Config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, hyprland, ... }@inputs:
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
		};
}
