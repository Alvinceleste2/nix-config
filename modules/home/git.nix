{
  config,
  lib,
  pkgs,
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
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Álvaro Grande";
          email = "github.hvgyj15x@alvinceleste.eu";
        };

        alias.st = "status";
        core.editor = "nvim";
        pull.rebase = true;
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
    };
  };
}
