{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  keyring_options = [ "gnome-keyring" ];
in
functions.makeModuleConfig {
  options = keyring_options;
  current = user_settings.keyring;
  module_name = "keyring";
}