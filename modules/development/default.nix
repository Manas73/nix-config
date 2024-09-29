{ pkgs, lib, development_apps, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  development_options = [ "gitkraken" "pycharm-professional" "datagrip" "postman" "sublime" ];
in
functions.makeModuleConfig {
  options = development_options;
  current = development_apps;
  module_name = "development";
}
