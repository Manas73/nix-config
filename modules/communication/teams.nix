{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  teamsPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.teams ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.teams ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "microsoft-teams" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "microsoft-teams" ];
    };
  };

  teamsConfig = lib.attrByPath [ system ] { } teamsPerPlatform;
in {
  options.teams.enable = lib.mkEnableOption "Enable Microsoft Teams";

  config = lib.mkIf config.teams.enable teamsConfig;
}