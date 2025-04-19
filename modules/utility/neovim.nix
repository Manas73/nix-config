{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  neovimPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.neovim ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.neovim ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.neovim ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.neovim ];
    };
  };

  neovimConfig = lib.attrByPath [ system ] { } neovimPerPlatform;
in {
  options.neovim.enable = lib.mkEnableOption "Enable Neovim editor";

  config = lib.mkIf config.neovim.enable neovimConfig;
}