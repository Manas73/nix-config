{ config, pkgs, user_settings, ... }:

let
  # Get all entries in the current directory
  entries = builtins.readDir ./.;

  # Filter out non-directories and create import paths
  imports = builtins.map
    (name: "./${name}")
    (builtins.filter
      (name: entries.${name} == "directory")
      (builtins.attrNames entries));
in
{
  imports = [
    ../base_user.nix
    ../../user_modules
    ./sops.nix
  ] ++ imports;

  programs.git.userName = "Manas73";
  programs.git.userEmail = "manas.sambare@gmail.com";

}