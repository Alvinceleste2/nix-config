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

    githubKeyPath = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Path to GitHub SSH private key";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "github.com" = lib.mkIf (cfg.githubKeyPath != null) {
          hostname = "github.com";
          user = "git";
          identityFile = cfg.githubKeyPath;
          identitiesOnly = true;
        };
      };
    };
  };
}
