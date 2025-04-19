{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  yabaiPerPlatform = {
    # Yabai is only available on macOS, so Linux platforms have empty configs
    "x86_64-linux" = { };
    "aarch64-linux" = { };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.yabai pkgs.jankyborders ];
      services.yabai.enable = true;
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.yabai pkgs.jankyborders ];
      services.yabai.enable = true;
    };
  };

  yabaiConfig = lib.attrByPath [ system ] { } yabaiPerPlatform;
in {
  options.yabai.enable = lib.mkEnableOption "Enable Yabai window manager";

  config = lib.mkIf config.yabai.enable yabaiConfig;
}