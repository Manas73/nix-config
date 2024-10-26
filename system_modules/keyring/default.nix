{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  keyring_options = [ "gnome-keyring" ];
in
functions.makeModuleConfig {
  options = keyring_options;
  current = system_settings.keyrings;
  module_name = "keyring";
}