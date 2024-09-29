{ pkgs, lib, communications, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  communication_options = [ "slack" "zoom" "teams" "rambox" ];
in
functions.makeModuleConfig {
  options = communication_options;
  current = communications;
  module_name = "communication";
}
