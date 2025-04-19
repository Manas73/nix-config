{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  gpartedPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.gparted ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.gparted ];
    };
    # GParted is only available on Linux, so macOS platforms have empty configs
    "x86_64-darwin" = { };
    "aarch64-darwin" = { };
  };

  gpartedConfig = lib.attrByPath [ system ] { } gpartedPerPlatform;
in {
  options.gparted.enable = lib.mkEnableOption "Enable GParted partition editor";

  config = lib.mkIf config.gparted.enable gpartedConfig;
}