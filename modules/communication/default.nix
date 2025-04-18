{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  communication_options = [ "slack" "zoom" "teams" "rambox" ];
in
functions.makeModuleConfig {
  options = communication_options;
  current = system_settings.communications;
  module_name = "communication";
}