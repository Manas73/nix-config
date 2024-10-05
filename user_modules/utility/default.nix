{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  utility_options = [ "stow" "btop" "ghq" "atuin" "yazi" "greenclip" "zellij" "flameshot" "gparted" "_1password" "zoxide" "dropbox" "starship" ];
in
functions.makeModuleConfig {
  options = utility_options;
  current = user_settings.utilities;
  module_name = "utility";
}
