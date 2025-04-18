{ pkgs, lib, system_settings, ... }:

let
  functions = import ../functions.nix { inherit pkgs lib; };
  browser_options = [ "vivaldi" "firefox" "brave"];
in
  functions.makeModuleConfig {
    options = browser_options;
    current = system_settings.browsers;
    module_name = "browser";
  }