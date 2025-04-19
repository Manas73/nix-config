{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  bravePerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.brave ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.brave ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "brave-browser" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "brave-browser" ];
    };
  };

  braveConfig = lib.attrByPath [ system ] { } bravePerPlatform;
in {
  options.brave.enable = lib.mkEnableOption "Enable Brave browser";

  config = lib.mkIf config.brave.enable braveConfig;
}