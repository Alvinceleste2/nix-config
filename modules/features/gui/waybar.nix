{ self, ... }:
{
  flake.modules.homeManager.waybarLaptop = {
    imports = [
      self.modules.homeManager.waybarCore
      self.modules.homeManager.waybarClock
      self.modules.homeManager.waybarHyprlandWorkspaces
      self.modules.homeManager.waybarHyprlandWindow
      self.modules.homeManager.waybarDisk
      self.modules.homeManager.waybarMemory
      self.modules.homeManager.waybarCpu
      self.modules.homeManager.waybarNetwork
      self.modules.homeManager.waybarBattery
      self.modules.homeManager.waybarBacklight
      self.modules.homeManager.waybarPulseaudio
    ];
  };

  flake.modules.homeManager.waybarDesktop = {
    imports = [
      self.modules.homeManager.waybarCommon
    ];
  };

  flake.modules.homeManager.waybarCore =
    { lib, ... }:
    {
      imports = [
        self.modules.homeManager.fontsFantasqueSansMono
      ];

      programs.waybar.enable = true;

      programs.waybar = {
        settings.mainBar = {
          layer = "top";
          position = "top";
          mod = "dock";
          height = 40;
        };

        style = ''
          @define-color base            #191724;
          @define-color surface         #1f1d2e;
          @define-color overlay         #26233a;

          @define-color muted           #6e6a86;
          @define-color subtle          #908caa;
          @define-color text            #e0def4;

          @define-color love            #eb6f92;
          @define-color gold            #f6c177;
          @define-color rose            #ebbcba;
          @define-color pine            #31748f;
          @define-color foam            #9ccfd8;
          @define-color iris            #c4a7e7;

          @define-color highlightLow    #21202e;
          @define-color highlightMed    #403d52;
          @define-color highlightHigh   #524f67;

          * {
            font-family: "FantasqueSansM Nerd Font";
            font-weight: bold;
            font-size: 12px;
            min-height: 0;
          }

          window#waybar {
            background-color: transparent;
            color: @text;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarClock =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          clock = {
            format = "  {:%H:%M %p    %a, %b %e}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          modules-left = lib.mkAfter [
            "clock"
          ];
        };

        style = lib.mkAfter ''
          #clock {
            color: @gold;
            border-radius: 10px 10px 10px 10px;
            margin-left: 10px;
            margin-right: 5px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarHyprlandWorkspaces =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          "hyprland/workspaces" = {
            active-only = false;
            all-outputs = true;
            format = "{icon}";
            persistent_workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
            };
            format-icons = {
              "1" = "󰧞";
              "2" = "󰧞";
              "3" = "󰧞";
              "4" = "󰧞";
              "5" = "󰧞";
              urgent = "";
              active = "";
              default = "󰧞";
              sort-by-number = true;
            };
          };

          modules-left = lib.mkAfter [
            "hyprland/workspaces"
          ];
        };

        style = lib.mkAfter ''
          #workspaces {
            border-radius: 10px;
            margin-left: 5px;
            padding: 0px 5px;
          }

          #workspaces.button {
            padding: 5px;
            color: #313244;
            margin-right: 5px;
          }

          #workspaces button.active {
            color: #a6adc8;
            border-radius: 10px;
          }

          #workspaces button.urgent {
            color: #a6adc8;
            border-radius: 10px;
          }

          #workspaces button:hover {
            color: #a6adc8;
            border-radius: 10px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarHyprlandWindow =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          "hyprland/window" = {
            format = "{}";
          };

          modules-center = lib.mkAfter [
            "hyprland/window"
          ];
        };

        style = lib.mkAfter ''
          #window {
            border-radius: 10px;
            margin-left: 60px;
            margin-right: 60px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarDisk =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          disk = {
            interval = 30;
            format = "󰆼 {percentage_used}%";
            path = "/";
          };

          modules-right = lib.mkAfter [
            "disk"
          ];
        };

        style = lib.mkAfter ''
          #disk {
            color: @love;
            border-radius: 10px 0px 0px 10px;
            border-right: 0px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarMemory =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          memory = {
            format = "  {}%";
            tooltip = "false";
          };

          modules-right = lib.mkAfter [
            "memory"
          ];
        };

        style = lib.mkAfter ''
          #memory {
            color: @foam;
            border-right: 0px;
            border-left: 0px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarCpu =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          cpu = {
            format = "  {usage}%";
            tooltip = "false";
          };

          modules-right = lib.mkAfter [
            "cpu"
          ];
        };

        style = lib.mkAfter ''
          #cpu {
            color: @gold;
            border-radius: 0px 10px 10px 0px;
            border-left: 0px;
            margin-right: 10px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarNetwork =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          network = {
            format-wifi = "  {signalStrength}%";
            format-ethernet = "{ipaddr}/{cidr}";
            tooltip-format = "{essid} - {ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "Disconnected ⚠";
          };

          modules-right = lib.mkAfter [
            "network"
          ];
        };

        style = lib.mkAfter ''
          #network {
            color: @rose;
            border-radius: 10px 0px 0px 10px;
            border-right: 0px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarBattery =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          battery = {
            interval = 1;
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-icons = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };

          modules-right = lib.mkAfter [
            "battery"
          ];
        };

        style = lib.mkAfter ''
          #battery {
            color: #96d197;
            border-left: 0px;
            border-right: 0px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarBacklight =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          backlight = {
            device = "intel_backlight";
            format = "{icon} {percent}%";
            format-icons = [
              "󰃞"
              "󰃟"
              "󰃠"
            ];
          };

          modules-right = lib.mkAfter [
            "backlight"
          ];
        };

        style = lib.mkAfter ''
          #backlight {
            color: @text;
            border-left: 0px;
            border-right: 0px;
          }
        '';
      };
    };

  flake.modules.homeManager.waybarPulseaudio =
    { lib, ... }:
    {
      programs.waybar = {
        settings.mainBar = {
          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰖁  Muted";
            format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [
                ""
                ""
                " "
              ];
            };
          };

          modules-right = lib.mkAfter [
            "pulseaudio"
          ];
        };

        style = lib.mkAfter ''
          #pulseaudio {
            color: @iris;
            border-radius: 0px 10px 10px 0px;
            border-left: 0px;
            margin-right: 10px;
          }
        '';
      };
    };
}
