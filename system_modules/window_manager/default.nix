{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  window_manager_options = [ "i3" "hyprland" ];
in
# Pass everything directly into the function, including imports
functions.makeModuleConfig {
  options = window_manager_options;
  current = system_settings.window_managers;
  module_name = "window_manager";
}
