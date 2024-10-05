{ pkgs, lib, config, user_settings, ... }: {

    options = {
        firefox.enable = lib.mkEnableOption "enables firefox";
    };

    config = lib.mkIf config.firefox.enable {
        home.packages = with pkgs; [ firefox ];
    };
}