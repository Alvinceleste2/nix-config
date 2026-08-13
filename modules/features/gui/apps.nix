{
  flake.modules.homeManager.apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        kdePackages.dolphin
        gnome-calculator

        spotify
        signal-desktop
        discord
        pencil
        libreoffice

        jellyfin-desktop
      ];
    };
}
