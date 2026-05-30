{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.graphics.audio;
in
{
  options.modules.graphics.audio.enable = lib.mkEnableOption "enables graphics/audio";

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pwvucontrol
      wireplumber
      pamixer
    ];
  };
}
