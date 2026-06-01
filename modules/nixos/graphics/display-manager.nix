{
  config,
  pkgs,
  lib,
  dir,
  desc,
  ...
}:

let
  cfg = lib.attrByPath dir { } config;
in
{
  options = lib.setAttrByPath dir {
    enable = lib.mkEnableOption desc;
    dm = lib.mkOption {
      description = "";
      type = lib.types.enum [
        "greetd"
        "ly"
        "sddm"
      ];
      default = "sddm";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      # Too much bloat :(
      (lib.mkIf (cfg.dm == "sddm") {
        services.displayManager.sddm.wayland.enable = true;
        services.displayManager.sddm = {
          enable = true;
          settings = {
            Autologin = {
              Relogin = false;
            };
            General = {
              RememberLastSession = true;
              RememberLastUser = true;
            };
          };
        };
      })

      (lib.mkIf (cfg.dm == "greetd") {
        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              # Buscamos las sesiones en los directorios del sistema de NixOS
              command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks";
              user = "greeter";
            };
          };
        };

        systemd.services.greetd.serviceConfig = {
          Type = "idle";
          StandardInput = "tty";
          StandardOutput = "null";
          StandardError = "journal";
          TTYReset = true;
          TTYVHangup = true;
          TTYVTDisallocate = true;
        };
      })

      # Ly display manager is not correctly managing past sessions.
      (lib.mkIf (cfg.dm == "ly") {
        services.displayManager.ly = {
          enable = true;
          settings = {
            save = true;
            load = true;
          };
        };
      })
    ]
  );
}
