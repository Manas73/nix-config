{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  zoxidePerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.zoxide ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.zoxide ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.zoxide ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.zoxide ];
    };
  };

  zoxideConfig = lib.attrByPath [ system ] { } zoxidePerPlatform;
in {
  options.zoxide.enable = lib.mkEnableOption "Enable zoxide smarter cd command";

  config = lib.mkIf config.zoxide.enable zoxideConfig;
} 