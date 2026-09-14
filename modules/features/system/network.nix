{
  flake.modules.nixos.network =
    { pkgs, ... }:
    {
      networking.networkmanager.enable = true;

      # eduroam :)
      security.pam.services.ly.enableKwallet = true;
      environment.systemPackages = with pkgs; [
        kdePackages.kwallet
        kdePackages.kwallet-pam
      ];
    };
}
