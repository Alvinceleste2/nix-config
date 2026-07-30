{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  # Get list of module files recursively, excluding "default.nix" and files whose prefix is "_" (private scope).
  allModuleFiles = builtins.filter (
    path:
    let
      name = builtins.baseNameOf path;
    in
    name != "default.nix" && !lib.hasPrefix "_" name
  ) (lib.filesystem.listFilesRecursive ./.);

  # Definition of loadModule function. It gets the path (absolute) of the module.
  loadModule =
    absolutePath:
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      # Generate the correct module name based on its location.
      relativeStr = lib.removeSuffix ".nix" (
        lib.removePrefix (toString ./. + "/") (toString absolutePath)
      );
      folderList = lib.splitString "/" relativeStr;

      # These parameters are passed to modules.
      dir = [
        "modules"
        "home"
      ]
      ++ folderList;
      desc = "${lib.concatStringsSep "/" dir}";
    in
    import absolutePath {
      inherit
        config
        lib
        pkgs
        # Additional parameters
        dir
        desc
        ;
    };
in
{
  imports = map loadModule allModuleFiles;
}
