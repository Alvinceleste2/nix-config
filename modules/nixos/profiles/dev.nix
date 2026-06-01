{
  config,
  pkgs,
  lib,
  dir,
  desc,
  ...
}:

let
  cfg = lib.attrByPath dir { } config;
in
{
  options = lib.setAttrByPath dir {
    enable = lib.mkEnableOption desc;
  };

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
