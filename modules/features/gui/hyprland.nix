{ self, ... }:
{
  flake.modules.nixos.hyprlandLaptop = {
    imports = with self.modules.nixos; [
      hyprlandCore
    ];

    home-manager.sharedModules = with self.modules.homeManager; [
      hyprlandLaptop
    ];
  };

  flake.modules.nixos.hyprlandDesktop = {
    imports = with self.modules.nixos; [
      hyprlandCore
    ];

    home-manager.sharedModules = with self.modules.homeManager; [
      hyprlandDesktop
    ];
  };

  flake.modules.nixos.hyprlandCore =
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

      # TODO: delete
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
        self.modules.homeManager.hyprlandCore
      ];
    };

  flake.modules.homeManager.hyprlandCore =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
      };

      imports = with self.modules.homeManager; [

        hyprlandAnimations
        hyprlandAutostart
        hyprlandCursor
        hyprlandDecoration
        hyprlandEnvironment
        hyprlandGestures
        hyprlandKeybindings
        hyprlandKeyboard
        hyprlandLayout
        # hyprlandMonitor
        hyprlandWindow
        hyprlandWindowrule
        hyprlandWorkspace

        kitty
        firefox
        zsh
        fuzzel
        dunst
        hyprlock
        hyprpaper
        apps
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
      ];
    };

  flake.modules.homeManager.hyprlandAnimations = {
    wayland.windowManager.hyprland.settings = {
      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
    };
  };

  flake.modules.homeManager.hyprlandAutostart = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        # Load Hypridle
        "hypridle"

        # Load Hyprpaper
        "hyprpaper"

        # Load Hyprpolkitagent
        "systemctl --user start hyprpolkitagent"

        # Load Cliphist
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # xdg-desktop-portal things
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };

  flake.modules.homeManager.hyprlandCursor =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bibata-cursors
      ];

      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 18;
      };

      wayland.windowManager.hyprland.settings = {
        env = [
          "XCURSOR_THEME,Bibata-Modern-Ice"
          "XCURSOR_SIZE,18"
        ];

        exec-once = [
          "hyprctl setcursor Bibata-Modern-Ice 18"
        ];
      };
    };

  flake.modules.homeManager.hyprlandDecoration = {
    wayland.windowManager.hyprland.settings = {
      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
        };

        shadow = {
          enabled = true;
          range = 30;
          render_power = 3;
          color = "0x66000000";
        };
      };
    };
  };

  flake.modules.homeManager.hyprlandGestures = {
    wayland.windowManager.hyprland.settings = {
      gesture = [
        "3, horizontal, workspace"
      ];
    };
  };

  flake.modules.homeManager.hyprlandKeybindings = {
    home.sessionVariables = {
      TERMINAL = "kitty";
      BROWSER = "firefox";
      LAUNCHER = "fuzzel";
      FILEMANAGER = "dolphin";
      CALCULATOR = "gnome-calculator";
    };

    wayland.windowManager.hyprland.settings =
      let
        mainMod = "SUPER";
      in
      {
        bind = [
          # Applications
          "${mainMod}, RETURN, exec, $TERMINAL"
          "${mainMod}, F, exec, $BROWSER"
          "${mainMod}, E, exec, $FILEMANAGER"
          "${mainMod}, C, exec, $CALCULATOR"
          "${mainMod}, SPACE, exec, $LAUNCHER"
          "${mainMod}, P, exec, hyprpicker -a"
          "${mainMod} ALT, L, exec, hyprlock"
          "SUPER, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"

          # Screenshots
          ", Print, exec, grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 3000"
          "SHIFT, Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of whole screen taken\" -t 3000"
          "${mainMod}, Print, exec, grim -g \"$(hyprctl activewindow -j | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"')\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of current window taken\" -t 3000"

          # Windows
          "${mainMod}, W, killactive"
          "${mainMod} SHIFT, W, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"
          "${mainMod} SHIFT, F, fullscreen, 0"
          "${mainMod}, M, fullscreen, 1"
          "${mainMod}, T, togglefloating"
          "${mainMod} SHIFT, T, workspaceopt, allfloat"

          # Navigation & Focus
          "${mainMod}, l, movefocus, l"
          "${mainMod}, h, movefocus, r"
          "${mainMod}, k, movefocus, u"
          "${mainMod}, j, movefocus, d"

          # Window Resizing (Keyboard)
          "${mainMod} CTRL, l, resizeactive, 100 0"
          "${mainMod} CTRL, h, resizeactive, -100 0"
          "${mainMod} CTRL, k, resizeactive, 0 -100"
          "${mainMod} CTRL, j, resizeactive, 0 100"

          # Groups & Swapping
          "${mainMod}, G, togglegroup"
          "${mainMod} SHIFT, h, swapwindow, l"
          "${mainMod} SHIFT, l, swapwindow, r"
          "${mainMod} SHIFT, k, swapwindow, u"
          "${mainMod} SHIFT, j, swapwindow, d"

          # Workspaces Switch
          "${mainMod}, 1, workspace, 1"
          "${mainMod}, 2, workspace, 2"
          "${mainMod}, 3, workspace, 3"
          "${mainMod}, 4, workspace, 4"
          "${mainMod}, 5, workspace, 5"
          "${mainMod}, 6, workspace, 6"
          "${mainMod}, 7, workspace, 7"
          "${mainMod}, 8, workspace, 8"
          "${mainMod}, 9, workspace, 9"
          "${mainMod}, 0, workspace, 10"

          # Workspaces Move Window
          "${mainMod} SHIFT, 1, movetoworkspace, 1"
          "${mainMod} SHIFT, 2, movetoworkspace, 2"
          "${mainMod} SHIFT, 3, movetoworkspace, 3"
          "${mainMod} SHIFT, 4, movetoworkspace, 4"
          "${mainMod} SHIFT, 5, movetoworkspace, 5"
          "${mainMod} SHIFT, 6, movetoworkspace, 6"
          "${mainMod} SHIFT, 7, movetoworkspace, 7"
          "${mainMod} SHIFT, 8, movetoworkspace, 8"
          "${mainMod} SHIFT, 9, movetoworkspace, 9"
          "${mainMod} SHIFT, 0, movetoworkspace, 10"

          # Mouse Workspaces
          "${mainMod}, mouse_down, workspace, e+1"
          "${mainMod}, mouse_up, workspace, e-1"
        ];

        bindm = [
          "${mainMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, resizewindow"
        ];

        bindle = [
          ", XF86AudioRaiseVolume, exec, pamixer -i 5 && dunstify -u low \"Volume: $(pamixer --get-volume)%\" -h string:x-dunst-stack-tag:volume -h int:value:$(pamixer --get-volume) -t 3000"
          ", XF86AudioLowerVolume, exec, pamixer -d 5 && dunstify -u low \"Volume: $(pamixer --get-volume)%\" -h string:x-dunst-stack-tag:volume -h int:value:$(pamixer --get-volume) -t 3000"
        ];

        bindl = [
          ", XF86AudioMute, exec, pamixer -t && dunstify -u low \"Volume: $(pamixer --get-volume-human)\" -h string:x-dunst-stack-tag:volume-mute -t 3000"
        ];
      };
  };

  flake.modules.homeManager.hyprlandKeyboard = {
    wayland.windowManager.hyprland.settings = {
      input = {
        kb_layout = "es";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";

        kb_options = "caps:swapescape"; # Remap Caps-Lock to Escape

        follow_mouse = 0;
        mouse_refocus = false;

        touchpad = {
          natural_scroll = true; # En Nix se pasa 'yes/no' a booleanos 'true/false'
          scroll_factor = 1.0;
          disable_while_typing = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification
      };
    };
  };

  flake.modules.homeManager.hyprlandLayout = {
    wayland.windowManager.hyprland.settings = {
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      binds = {
        workspace_back_and_forth = true;
      };
    };
  };

  flake.modules.homeManager.hyprlandWindow = {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = 3;
        gaps_out = 10;
        border_size = 3;

        "col.active_border" = "rgb(cdd6f4)";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
        resize_on_border = true;
      };
    };
  };

  flake.modules.homeManager.hyprlandWindowrule = {
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "float, title:Calculator"
      ];
    };
  };

  flake.modules.homeManager.hyprlandWorkspace = {
    wayland.windowManager.hyprland.settings = {
      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"
      ];
    };
  };

  flake.modules.homeManager.hyprlandEnvironment = {
    wayland.windowManager.hyprland.settings = {
      env = [
        "GDK_SCALE,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };
    };
  };

  flake.modules.homeManager.hyprlandLaptop = {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          # Brightness control
          ", XF86MonBrightnessUp, exec, brightnessctl set +5% && dunstify -u low \"Brightness: $(($(brightnessctl get) * 100 / $(brightnessctl m) ))\" -h string:x-dunst-stack-tag:brightness -h int:value:$(($(brightnessctl get) * 100 / $(brightnessctl m) )) -t 3000"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%- && dunstify -u low \"Brightness: $(($(brightnessctl get) * 100 / $(brightnessctl m) ))\" -h string:x-dunst-stack-tag:brightness -h int:value:$(($(brightnessctl get) * 100 / $(brightnessctl m) )) -t 3000"
        ];
      };
    };

    imports = with self.modules.homeManager; [
      waybarLaptop
      hypridleLaptop
    ];
  };

  flake.modules.homeManager.hyprlandDesktop = {
    imports = with self.modules.homeManager; [
      waybarLaptop
      hypridleDesktop
    ];
  };
}
