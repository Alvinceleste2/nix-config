{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.core.packages;
in
{
  options.modules.core.packages.enable = lib.mkEnableOption "enables core/packages";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      git
      curl
      htop
      zip
      unzip
      stow
      tree
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.config.allowUnfree = true;
  };
}
