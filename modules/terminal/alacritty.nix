{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  alacrittyPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.alacritty ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.alacritty ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "alacritty" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "alacritty" ];
    };
  };

  alacrittyConfig = lib.attrByPath [ system ] { } alacrittyPerPlatform;
in {
  options.alacritty.enable = lib.mkEnableOption "Enable Alacritty terminal";

  config = lib.mkIf config.alacritty.enable alacrittyConfig;
}