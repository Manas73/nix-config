{ pkgs, lib, config, user_settings, ... }: {

    options = {
        pycharm-professional.enable = lib.mkEnableOption "enables pycharm-professional";
    };

    config = lib.mkIf config.pycharm-professional.enable  {
        home.packages = with pkgs; [ jetbrains.pycharm-professional ];
    };
}
