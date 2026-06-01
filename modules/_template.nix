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
    # Settings defined by the module...
  };

  # If needed, one or more private submodules (starting with "_") can be imported dynamically this way. Note the differences: "()" after cfg.enable, "{}" for native options and "()" for the import clause.
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      #{
        # Native settings defined by the module...
      }

      #(import ./_private-module.nix { inherit pkgs ...; })
    ]
  );
}
