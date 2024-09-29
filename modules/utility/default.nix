{ pkgs, lib, utilities, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  utility_options = [ "stow" "btop" "ghq" "atuin" "yazi" "greenclip" "zellij" "flameshot" "gparted" "_1password" "zoxide" "dropbox" ];
in
functions.makeModuleConfig {
  options = utility_options;
  current = utilities;
  module_name = "utility";
}
