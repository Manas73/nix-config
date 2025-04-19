{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  greenclipPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.haskellPackages.greenclip ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.haskellPackages.greenclip ];
    };
    # Greenclip is only available on Linux, so macOS platforms have empty configs
    "x86_64-darwin" = { };
    "aarch64-darwin" = { };
  };

  greenclipConfig = lib.attrByPath [ system ] { } greenclipPerPlatform;
in {
  options.greenclip.enable = lib.mkEnableOption "Enable Greenclip clipboard manager";

  config = lib.mkIf config.greenclip.enable greenclipConfig;
}