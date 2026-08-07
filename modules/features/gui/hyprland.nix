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

      imports = [
        self.modules.nixos.display-manager
        self.modules.nixos.firefox
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

      imports = [
        self.modules.homeManager.kitty
        self.modules.homeManager.zsh
      ];

      home.packages = with pkgs; [
        hyprlock
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

        kitty
        firefox
        fuzzel
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
