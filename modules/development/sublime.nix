{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  sublimePerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.sublime4 ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.sublime4 ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "sublime-text" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "sublime-text" ];
    };
  };

  sublimeConfig = lib.attrByPath [ system ] { } sublimePerPlatform;
in {
  options.sublime.enable = lib.mkEnableOption "Enable Sublime Text";

  config = lib.mkIf config.sublime.enable sublimeConfig;
}