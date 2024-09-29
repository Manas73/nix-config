{ pkgs, lib, utilities, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  utility_options = [ "stow" "btop" "ghq" ];
in
functions.makeModuleConfig {
  options = utility_options;
  current = utilities;
  module_name = "utility";
}
