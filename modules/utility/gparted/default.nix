{ pkgs, lib, config, user_settings, ... }: {

    options = {
        gparted.enable = lib.mkEnableOption "enables gparted";
    };

    config = lib.mkIf config.gparted.enable  {
        home.packages = with pkgs; [ gparted ];
    };
}
