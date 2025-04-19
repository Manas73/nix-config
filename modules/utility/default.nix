{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  utility_options = [ 
    "stow" "btop" "ghq" "atuin" "yazi" "zellij" "_1password" "zoxide" 
    "starship" "eza" "fzf" "neovim" "lazygit" "pyenv" "chezmoi" 
    "raycast" "skhd" "yabai" "greenclip" "flameshot" "gparted" 
    "psmisc" "kanata" "sketchybar"
  ];
in
functions.makeModuleConfig {
  options = utility_options;
  current = user_settings.utilities;
  module_name = "utility";
}