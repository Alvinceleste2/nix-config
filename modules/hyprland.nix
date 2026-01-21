{ config, pkgs, inputs, ... }:

{
	programs.hyprland = {
		enable = true;
		#package = inputs.hyprland.packages."${pkgs.system}".hyprland; };
	};


  environment.systemPackages = with pkgs; [
    # desktop environment
    bibata-cursors
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    brightnessctl
    waybar
    cliphist

    # programs
    kitty
    firefox
    gnome-calculator
    kdePackages.dolphin

    # technical stuff
    pipewire
    wireplumber
  ];
}
