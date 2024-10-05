{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  terminal_options = [ "alacritty" "kitty" ];
in
functions.makeModuleConfig {
  options = terminal_options;
  current = user_settings.terminals;
  module_name = "terminal";
}
