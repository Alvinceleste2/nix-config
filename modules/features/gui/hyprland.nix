{ self, ... }:
{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      };

      environment.sessionVariables = {
        HOSTNAME = "laptop";
      };

      imports = with self.modules.nixos; [
        display-manager
        audio
        fonts
      ];

      home-manager.sharedModules = [
        self.modules.homeManager.hyprland
      ];
    };

  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      #wayland.windowManager.hyprland = {
      #  enable = true;
      #};

      imports = with self.modules.homeManager; [
        kitty
        firefox
        zsh
        fuzzel
        dunst
        hyprlock
      ];

      home.packages = with pkgs; [
        hypridle
        hyprpaper
        hyprpicker
        waybar
        cliphist
        wl-clipboard
        grim
        slurp
        jq
        rose-pine-icon-theme
        rose-pine-gtk-theme
        bibata-cursors

        brightnessctl

        ###

        kdePackages.dolphin
        gnome-calculator

        spotify
        signal-desktop
        discord
        pencil
        libreoffice

        jellyfin-desktop
      ];

      home.sessionVariables = {
        TERMINAL = "kitty";
        BROWSER = "firefox";
        LAUNCHER = "fuzzel";
        FILEMANAGER = "dolphin";
        CALCULATOR = "gnome-calculator";
      };
    };
}
