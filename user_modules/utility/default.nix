{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  utility_options = [ "stow" "btop" "ghq" "atuin" "yazi" "greenclip" "zellij" "flameshot" "gparted" "_1password" "zoxide" "starship" "eza" "fzf" "neovim" "lazygit" "pyenv" "psmisc" "chezmoi" "input-remapper" ];
in
functions.makeModuleConfig {
  options = utility_options;
  current = user_settings.utilities;
  module_name = "utility";
}
