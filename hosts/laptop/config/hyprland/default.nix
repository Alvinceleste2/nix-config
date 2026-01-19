{ config, pkgs, ... }:

{
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			input = {
				kb_layout = "es";
				kb_options = caps:swapescape;

				follow_mouse = 0;
				mouse_refocus = 0;

				touchpad = {
					natural_scroll = true;
					disable_while_typing = true;
				};

				sensitivity = 0;
			};

			"$mod" = "SUPER";

			bind = [
				"$mod, Return, exec, kitty"
			];
		};
	};
}
