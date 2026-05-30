{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.profiles.dev;
in
{
  options.modules.profiles.dev.enable = lib.mkEnableOption "enables profiles/dev";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      python312

      dos2unix
      gnumake

      typst
      tinymist
      websocat

      neovim
      tree-sitter
      nodejs_24
    ];
  };
}
