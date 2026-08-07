{
  flake.modules.nixos.network =
    { pkgs, ... }:
    {
      networking.networkmanager.enable = true;

      # needed for eduroam
      environment.systemPackages = with pkgs; [
        networkmanagerapplet
      ];
      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true;
    };
}
