{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  shell_options = [ "fish" ];
in
functions.makeModuleConfig {
  options = shell_options;
  current = system_settings.shells;
  module_name = "shell";
}
