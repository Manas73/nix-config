{ pkgs, lib, config, username, ... }: {

    options = {
        pycharm-professional.enable = lib.mkEnableOption "enables pycharm-professional";
    };

    config = lib.mkIf config.pycharm-professional.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ jetbrains.pycharm-professional ];
        };
    };
}
