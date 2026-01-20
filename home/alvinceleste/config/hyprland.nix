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

	wayland.windowManager.hyprland.enable = true;

	wayland.windowManager.hyprland.settings = {

		# ANIMATION #

		"animations.enabled" = true;

		"animations.bezier" = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];

		"animations.animation" = [
			"windows, 1, 7, myBezier"
			"windowsOut, 1, 7, default, popin 80%"
			"border, 1, 10, default"
			"borderangle, 1, 8, default"
			"fade, 1, 7, default"
			"workspaces, 1, 6, default"
		];


		# AUTOSTART - CURSOR #

		xwayland = {
			force_zero_scaling = true;
		};

		exec-once = [
			"waybar"
			"hypridle"
			"hyprpaper"
			"wl-paste --type text --watch cliphist store"
			"wl-paste --type image --watch cliphist store"
			"hyprctl setcursor Bibata-Modern-Ice 24"
			"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
			"systemctl --user import-environment WAYLAND DISPLAY XDG_CURRENT_DESKTOP"
			"systemctl --user start hyprpolkitagent"
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

			"$mod, l, movefocus, l"
			"$mod, h, movefocus, r"
			"$mod, k, movefocus, u"
			"$mod, j, movefocus, d"

			"$mod ALT, l, resizeactive, 100 0"
			"$mod ALT, h, resizeactive, -100 0"
			"$mod ALT, k, resizeactive, 0 -100"
			"$mod ALT, j, resizeactive, 0 100"

			"$mod SHIFT, h, swapwindow, l"
			"$mod SHIFT, l, swapwindow, r"
			"$mod SHIFT, k, swapwindow, u"
			"$mod SHIFT, j, swapwindow, d"

			"$mod, 1, workspace, 1"
			"$mod, 2, workspace, 2"
			"$mod, 3, workspace, 3"
			"$mod, 4, workspace, 4"
			"$mod, 5, workspace, 5"
			"$mod, 6, workspace, 6"
			"$mod, 7, workspace, 7"
			"$mod, 8, workspace, 8"
			"$mod, 9, workspace, 9"
			"$mod, 0, workspace, 0"

			"$mod SHIFT, 1, movetoworkspace, 1"
			"$mod SHIFT, 2, movetoworkspace, 2"
			"$mod SHIFT, 3, movetoworkspace, 3"
			"$mod SHIFT, 4, movetoworkspace, 4"
			"$mod SHIFT, 5, movetoworkspace, 5"
			"$mod SHIFT, 6, movetoworkspace, 6"
			"$mod SHIFT, 7, movetoworkspace, 7"
			"$mod SHIFT, 8, movetoworkspace, 8"
			"$mod SHIFT, 9, movetoworkspace, 9"
			"$mod SHIFT, 0, movetoworkspace, 0"

			"$mod, mouse_down, workspace, e+1"
			"$mod, mouse_up, workspace, e+2"
		];
		
		bindm = [
			"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizeactive"
		];

		# KEYBOARD #
		
		input = {
			kb_layout = "es";
			kb_options = caps:swapescape;

			follow_mouse = 0;
			mouse_refocus = false;
			sensitivity = 0;
		};

		# LAYOUT #

		dwindle = {
			pseudotile = true;
			preserve_split = true;
			force_split = 2;
		};

		binds = {
			workspace_back_and_forth = true;
		};

		# MONITOR #

		monitor = [ ", preferred, auto, 1.333333" ];

		# WINDOW #

		general = {
			gaps_in = 3;
			gaps_out = 10;
			border_size = 3;
			"col.active_border" = "rgb(cdd6f4)";
			"col.inactive_border" = "rgba(595959aa)";

			layout = "dwindle";
			resize_on_border = true;
		};

		# WORKSPACE #

		workspace = [
			"1, persistent:true"
			"2, persistent:true"
			"3, persistent:true"
			"4, persistent:true"
			"5, persistent:true"
		];
	};
}
