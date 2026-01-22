{ config, pkgs, inputs, ... }:

{
	programs.hyprland = {
		enable = true;
    xwayland.enable = true;
		#package = inputs.hyprland.packages."${pkgs.system}".hyprland; };
	};

  services.pipewire = {
     enable = true;
     alsa.enable = true;
     pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # desktop environment
    bibata-cursors
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    waybar
    cliphist
    wl-clipboard
    grim
    slurp
    dunst
    rose-pine-icon-theme
    rose-pine-gtk-theme
    # nwg-look

    # programs
    kitty
    firefox
    gnome-calculator
    kdePackages.dolphin
    fuzzel

    # technical stuff
    pipewire
    wireplumber
    pamixer
    brightnessctl
  ];
}
