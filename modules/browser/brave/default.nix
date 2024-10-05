{ pkgs, lib, config, user_settings, ... }: {

    options = {
        brave.enable = lib.mkEnableOption "enables brave";
    };

    config = lib.mkIf config.brave.enable  {
        home.packages = with pkgs; [ brave ];
    };
}
