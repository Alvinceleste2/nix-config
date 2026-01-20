{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		kitty
		firefox
		thunar
		gnome-calculator
		hyprpicker
		hyprlock
		cliphist
		fuzzel
	];

	wayland.windowManager.hyprland.settings = {

		# AUTOSTART - CURSOR #

		exec-once = [
			"waybar"
			"hypridle"
			"hyprpaper"
			"wl-paste --type text --watch cliphist store"
			"wl-paste --type image --watch cliphist store"
			"hyprctl setcursor Bibata-Modern-Ice 24"
		];

		# DECORATION #

		decoration = {
			rounding = 10;

			blur = {
				enabled = true;
				size = 6;
				passes = 2;
				new_optimizations = "on";
				ignore_opacity = true;
				xray = true;
			};

			shadow = {
				enabled = true;
				range = 30;
				render_power = 3;
				color = "0x66000000";
			};
		};
		
		# ENVIRONMENT #

		env = [
			"GDK_SCALE, 1"
		];

		# BINDINGS #

		"$mod" = "SUPER";

		bind = [
			"$mod, RETURN, exec, kitty"
			"$mod, F, exec, firefox"
			"$mod, E, exec, thunar"
			"$mod, C, exec, gnome-calculator"
			"$mod, P, exec, hyprpicker -a"
			"$mod ALT, L, exec, hyprlock"

			"$mod, SPACE, exec, fuzzel"
			"SUPER, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
			", Print, exec, grim -g '$(slurp)' - | swappy -f -"

			"$mod, W, killactive"
			"$mod SHIFT, W, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"
			"$mod SHIFT, F, exec, fullscreen, 0"
			"$mod, M, fullscreen, 1"
			"$mod, T, toggleFloating"
			"$mod SHIFT, T, workspaceopt, allfloat"
		];


		# INPUT #
		input = {
		 	kb_layout = "es";
		};

		monitor = ", auto, auto, 1";
	};
}
