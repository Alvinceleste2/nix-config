{ ... }:
{

  flake.modules.nixos.rbw = { };

  flake.modules.homeManager.rbw = { pkgs, ... }: {
    home.packages = with pkgs; [
      rofi-rbw
      fuzzel
      wtype
      wl-clipboard
      # May be changed in the future
      pinentry-qt
    ];

    programs.rbw = {
      enable = true;
      settings = {
        email = "example@email.com";
        pinentry = pkgs.pinentry-qt;
        lock_timeout = 1800;
      };
    };

    xdg.configFile."rofi-rbw.rc".text = ''
      action = type
      selector = fuzzel
      typer = wtype
    '';
  };
}
