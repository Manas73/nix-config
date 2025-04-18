{ pkgs, ... }:

let
  # Get all entries in the current directory
  entries = builtins.readDir ./.;

  # Filter out non-directories and create import paths
  moduleImports = builtins.map
    (name: ./${name})
    (builtins.filter
      (name: entries.${name} == "directory" && name != "default.nix")
      (builtins.attrNames entries));
in
{
  imports = moduleImports;
}