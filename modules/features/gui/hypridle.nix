{ self, ... }:
{
  flake.modules.homeManager.hypridle =
    { pkgs, ... }:
    {
      imports = with self.modules.homeManager; [
        hyprlock
      ];

      home.packages = with pkgs; [
        hypridle
        brightnessctl
      ];

      services.hypridle = {
        enable = true;
        package = pkgs.hypridle;

        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "hyprctl dispatch dpms off && sleep 1 && hyprlock";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener = [
            # 2.5 min: Brillo al mínimo (solo si no es "desktop")
            {
              timeout = 150;
              on-timeout = "[ $HOSTNAME == \"desktop\" ] || brightnessctl -s set 10";
              on-resume = "[ $HOSTNAME == \"desktop\" ] || brightnessctl -r";
            }
            # 5 min: Bloquear pantalla (solo si no es "desktop")
            {
              timeout = 300;
              on-timeout = "[ $HOSTNAME == \"desktop\" ] || hyprlock";
            }
            # 5 min: Apagar monitores (DPMS)
            {
              timeout = 300;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            # 30 min: Suspender el sistema
            {
              timeout = 1800;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };
}
