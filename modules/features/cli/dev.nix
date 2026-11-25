{ self, ... }:
{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      imports = [
        self.modules.nixos.unstable
      ];

      environment.systemPackages = with pkgs; [
        gcc
        gnumake
        dos2unix

        python3

        unstable.typst

        sage

        # lean
        # leanPackages.mathlib
        elan

        opencode

        nodejs_26
      ];
    };
}
