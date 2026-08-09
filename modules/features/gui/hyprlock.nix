{ self, ... }:
{
  flake.modules.homeManager.hyprlock =
    let
      wallpaper = "${self}/assets/wallpaper.jpg";
    in
    {
      programs.hyprlock = {
        enable = true;

        settings = {
          general = { };

          background = [
            {
              monitor = "";
              path = wallpaper;
              blur_passes = 2;
              contrast = 0.8916;
              brightness = 0.8172;
              vibrancy = 0.1696;
              vibrancy_darkness = 0.0;
            }
          ];

          shape = [
            # USER-BOX
            {
              monitor = "";
              size = "400, 80";
              color = "rgba(255, 255, 255, .1)";
              rounding = -1;
              border_size = 0;
              border_color = "rgba(255, 255, 255, 0)";
              rotate = 0;
              xray = false;
              position = "0, -100";
              halign = "center";
              valign = "center";
            }
          ];

          input-field = [
            {
              monitor = "";
              size = "400, 80";
              outline_thickness = 2;
              dots_size = 0.2;
              dots_spacing = 0.2;
              dots_center = true;
              outer_color = "rgba(255, 255, 255, 0)";
              inner_color = "rgba(255, 255, 255, 0.1)";
              font_color = "rgb(200, 200, 200)";
              fade_on_empty = false;
              font_family = "FantasqueSansM Nerd Font";
              font_size = 24;
              placeholder_text = "<i><span foreground=\"##ffffff99\">Enter Password...</span></i>";
              hide_input = false;
              position = "0, -220";
              halign = "center";
              valign = "center";
            }
          ];

          label = [
            # Time
            {
              monitor = "";
              text = "cmd[update:1000] echo \"<span>$(date +\"- %H:%M:%S -\")</span>\"";
              color = "rgba(216, 222, 233, 0.70)";
              font_size = 100;
              font_family = "FantasqueSansM Nerd Font";
              position = "0, 350";
              halign = "center";
              valign = "center";
            }
            # Day
            {
              monitor = "";
              text = "cmd[update:1000] echo -e \"$(date +\"%A\"), $(date +\"%d %B\")\"";
              color = "rgba(216, 222, 233, 0.70)";
              font_size = 40;
              font_family = "FantasqueSansM Nerd Font";
              position = "0, 230";
              halign = "center";
              valign = "center";
            }
            # USER
            {
              monitor = "";
              text = "    $USER";
              color = "rgba(216, 222, 233, 0.80)";
              font_size = 24;
              font_family = "FantasqueSansM Nerd Font";
              position = "0, -100";
              halign = "center";
              valign = "center";
            }
            # Reboot
            {
              monitor = "";
              text = "󰜉 ‎";
              color = "rgba(255, 255, 255, 0.6)";
              font_size = 50;
              font_family = "FantasqueSansM Nerd Font";
              onclick = "reboot now";
              position = "0, 160";
              halign = "center";
              valign = "bottom";
            }
            # Power off
            {
              monitor = "";
              text = "󰐥 ‎";
              color = "rgba(255, 255, 255, 0.6)";
              font_size = 50;
              font_family = "FantasqueSansM Nerd Font";
              onclick = "shutdown now";
              position = "820, 160";
              halign = "left";
              valign = "bottom";
            }
            # Suspend
            {
              monitor = "";
              text = "󰤄 ‎";
              color = "rgba(255, 255, 255, 0.6)";
              font_size = 50;
              font_family = "FantasqueSansM Nerd Font";
              onclick = "systemctl suspend";
              position = "-820, 160";
              halign = "right";
              valign = "bottom";
            }
          ];
        };
      };
    };
}
