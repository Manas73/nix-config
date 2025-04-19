{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  sketchybarPerPlatform = {
    # Sketchybar is only available on macOS, so Linux platforms have empty configs
    "x86_64-linux" = { };
    "aarch64-linux" = { };
    "x86_64-darwin" = {
      homebrew.casks = [ "sf-symbols" ];
      environment.systemPackages = [ pkgs.jq pkgs.gh pkgs.sketchybar-app-font ];
      services.sketchybar = {
        enable = true;
        package = pkgs.sketchybar;
      };
      system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "sf-symbols" ];
      environment.systemPackages = [ pkgs.jq pkgs.gh pkgs.sketchybar-app-font ];
      services.sketchybar = {
        enable = true;
        package = pkgs.sketchybar;
      };
      system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    };
  };

  sketchybarConfig = lib.attrByPath [ system ] { } sketchybarPerPlatform;
in {
  options.sketchybar.enable = lib.mkEnableOption "Enable Sketchybar status bar";

  config = lib.mkIf config.sketchybar.enable sketchybarConfig;
}