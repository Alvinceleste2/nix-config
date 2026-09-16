{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gcc
        gnumake
        dos2unix

        python3

        typst

        sage
      ];
    };
}
