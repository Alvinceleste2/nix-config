{ self, ... }:
{
  flake.modules.homeManager.hyprpaper =
    { pkgs, ... }:
    let
      wallpaper = "${self}/assets/wallpaper.jpg";
    in
    {

      home.packages = with pkgs; [
        hyprpaper
      ];

      services.hyprpaper = {
        enable = true;
        package = pkgs.hyprpaper;

        settings = {
          ipc = "on";
          splash = false;

          # PreCarga de la imagen desde el Nix Store
          preload = [
            wallpaper
          ];

          # Asignación de la imagen al monitor primario
          wallpaper = [
            {
              monitor = "";
              path = wallpaper;
              fit_mode = "fill";
            }
          ];
        };
      };
    };
}
