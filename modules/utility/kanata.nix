{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  kanataPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.kanata ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.kanata ];
    };
    # Kanata is only available on Linux, so macOS platforms have empty configs
    "x86_64-darwin" = { };
    "aarch64-darwin" = { };
  };

  kanataConfig = lib.attrByPath [ system ] { } kanataPerPlatform;
in {
  options.kanata.enable = lib.mkEnableOption "Enable Kanata keyboard remapper";

  config = lib.mkIf config.kanata.enable kanataConfig;
}