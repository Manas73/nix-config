{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  kittyPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.kitty ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.kitty ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "kitty" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "kitty" ];
    };
  };

  kittyConfig = lib.attrByPath [ system ] { } kittyPerPlatform;
in {
  options.kitty.enable = lib.mkEnableOption "Enable Kitty terminal";

  config = lib.mkIf config.kitty.enable kittyConfig;
}