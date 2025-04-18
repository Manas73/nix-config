{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  communication_options = [ "slack" "zoom" "teams" "rambox" ];
in
functions.makeModuleConfig {
  options = communication_options;
  current = user_settings.communications;
  module_name = "communication";
}