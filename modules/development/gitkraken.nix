{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  gitkrakenPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.gitkraken ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.gitkraken ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "gitkraken" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "gitkraken" ];
    };
  };

  gitkrakenConfig = lib.attrByPath [ system ] { } gitkrakenPerPlatform;
in {
  options.gitkraken.enable = lib.mkEnableOption "Enable GitKraken Git client";

  config = lib.mkIf config.gitkraken.enable gitkrakenConfig;
}