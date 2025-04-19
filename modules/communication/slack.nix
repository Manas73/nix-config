{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  slackPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.slack ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.slack ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "slack" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "slack" ];
    };
  };

  slackConfig = lib.attrByPath [ system ] { } slackPerPlatform;
in {
  options.slack.enable = lib.mkEnableOption "Enable Slack";

  config = lib.mkIf config.slack.enable slackConfig;
}