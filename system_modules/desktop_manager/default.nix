{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  desktop_manager_options = [ "plasma6" ];
in
functions.makeModuleConfig {
  options = desktop_manager_options;
  current = system_settings.desktop_managers;
  module_name = "desktop_manager";
}
