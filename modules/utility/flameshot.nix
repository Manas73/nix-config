{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  flameshotPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.flameshot ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.flameshot ];
    };
    # Flameshot is only available on Linux, so macOS platforms have empty configs
    "x86_64-darwin" = { };
    "aarch64-darwin" = { };
  };

  flameshotConfig = lib.attrByPath [ system ] { } flameshotPerPlatform;
in {
  options.flameshot.enable = lib.mkEnableOption "Enable Flameshot screenshot tool";

  config = lib.mkIf config.flameshot.enable flameshotConfig;
}