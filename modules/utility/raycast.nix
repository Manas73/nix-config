{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  raycastPerPlatform = {
    # Raycast is only available on macOS, so Linux platforms have empty configs
    "x86_64-linux" = { };
    "aarch64-linux" = { };
    "x86_64-darwin" = {
      homebrew.casks = [ "raycast" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "raycast" ];
    };
  };

  raycastConfig = lib.attrByPath [ system ] { } raycastPerPlatform;
in {
  options.raycast.enable = lib.mkEnableOption "Enable Raycast launcher";

  config = lib.mkIf config.raycast.enable raycastConfig;
}