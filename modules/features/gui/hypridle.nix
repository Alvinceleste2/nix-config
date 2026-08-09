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
            # 2.5 min: Minimun brightness
            {
              timeout = 150;
              on-timeout = "brightnessctl -s set 10";
              on-resume = "brightnessctl -r";
            }
            # 5 min: Lock Screen
            {
              timeout = 300;
              on-timeout = "hyprlock";
            }
            # 5 min: Shutdown Monitors (DPMS)
            {
              timeout = 300;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            # 30 min: System Suspend
            {
              timeout = 1800;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };
}
