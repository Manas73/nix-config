{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  zoomPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.zoom-us ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.zoom-us ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "zoom" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "zoom" ];
    };
  };

  zoomConfig = lib.attrByPath [ system ] { } zoomPerPlatform;
in {
  options.zoom.enable = lib.mkEnableOption "Enable Zoom";

  config = lib.mkIf config.zoom.enable zoomConfig;
}