{
  flake.modules.nixos.display-manager =
    { pkgs, ... }:
    {
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
    };
}
