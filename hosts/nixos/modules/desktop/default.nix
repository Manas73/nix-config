{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  desktop_manager_options = [ "plasma" "i3" ];
in
functions.makeModuleConfig {
  options = desktop_manager_options;
  current = system_settings.desktops;
  module_name = "desktop";
  conditional_imports = [ ./common.nix ];
}
