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
        home-manager
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
        hypridle
        hyprpaper
        apps
        waybarLaptop
      ];

      home.packages = with pkgs; [
        brightnessctl
        hyprpicker

        cliphist
        wl-clipboard
        grim
        slurp
        jq
        rose-pine-icon-theme
        rose-pine-gtk-theme
        bibata-cursors
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
