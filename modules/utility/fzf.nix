{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  fzfPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.fzf ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.fzf ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.fzf ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.fzf ];
    };
  };

  fzfConfig = lib.attrByPath [ system ] { } fzfPerPlatform;
in {
  options.fzf.enable = lib.mkEnableOption "Enable fzf fuzzy finder";

  config = lib.mkIf config.fzf.enable fzfConfig;
}