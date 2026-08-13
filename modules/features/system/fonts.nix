{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.fantasque-sans-mono
      ];

      fonts.fontconfig.defaultFonts = {
        sansSerif = [ "FantasqueSansM Nerd Font" ];
        serif = [ "FantasqueSansM Nerd Font" ];
        monospace = [ "FantasqueSansM Nerd Font Mono" ];
      };

      fonts.fontconfig.enable = true;
    };

  flake.modules.homeManager.fontsFantasqueSansMono =
    { pkgs, ... }:
    {
      fonts.fontconfig.enable = true;

      home.packages = [
        pkgs.nerd-fonts.fantasque-sans-mono
      ];
    };
}
