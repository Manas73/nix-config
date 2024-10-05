{ pkgs, lib, config, user_settings, ... }: {

    options = {
        vivaldi.enable = lib.mkEnableOption "enables vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {
        home.packages = with pkgs; [ vivaldi ];
    };
}