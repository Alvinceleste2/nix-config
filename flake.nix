{
	description = "NixOS Config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		hyprland.url = "github:hyprwm/Hyprland";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, hyprland, home-manager, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in
		{
			nixosConfigurations = {
				laptop = nixpkgs.lib.nixosSystem {
					inherit system;
					specialArgs = { inherit inputs; };
					modules = [
						./hosts/laptop/configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								backupFileExtension = "backup";
								users.alvinceleste = import ./home/alvinceleste/home.nix;
								extraSpecialArgs = { inherit inputs; };
							};
						}
					];
				};
		};
	};
}
