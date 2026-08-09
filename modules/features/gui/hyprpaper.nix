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
            "eDP-1,${wallpaper}"
          ];

          # NOTA: Si llegas a actualizar a las versiones más recientes de hyprpaper
          # que usan la sintaxis de bloque `wallpaper = { monitor = ... }`,
          # la estructura en Nix Manager sería la siguiente (comentada por ahora):
          /*
            wallpaper = [
              {
                monitor = ""; # Para aplicar a todos (*) o pon "eDP-1"
                path = wallpaper;
                fit_mode = "fill";
              }
            ];
          */
        };
      };
    };
}
