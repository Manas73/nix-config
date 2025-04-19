{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  dagripPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.jetbrains.datagrip ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.jetbrains.datagrip ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "datagrip" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "datagrip" ];
    };
  };

  dagripConfig = lib.attrByPath [ system ] { } dagripPerPlatform;
in {
  options.datagrip.enable = lib.mkEnableOption "Enable DataGrip";

  config = lib.mkIf config.datagrip.enable dagripConfig;
}