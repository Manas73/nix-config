{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  terminal_options = [ "alacritty" "kitty" ];
in
functions.makeModuleConfig {
  options = terminal_options;
  current = system_settings.terminals;
  module_name = "terminal";
}