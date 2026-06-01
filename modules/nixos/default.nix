{ lib, ... }:
{
  imports = builtins.filter (
    path:
    let
      name = builtins.baseNameOf path;
    in
    name != "default.nix" && !lib.hasPrefix "_" name
  ) (lib.filesystem.listFilesRecursive ./.);
}
