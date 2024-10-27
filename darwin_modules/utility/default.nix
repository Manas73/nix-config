{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  utility_options = [ "stow" "btop" "ghq" "atuin" "yazi" "zellij" "_1password" "zoxide" "starship" "eza" "fzf" "neovim" "lazygit" "pyenv" "chezmoi" ];
in
functions.makeModuleConfig {
  options = utility_options;
  current = system_settings.utilities;
  module_name = "utility";
}
