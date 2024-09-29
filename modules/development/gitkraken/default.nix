{ pkgs, lib, config, username, ... }: {

    options = {
        gitkraken.enable = lib.mkEnableOption "enables gitkraken";
    };

    config = lib.mkIf config.gitkraken.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ gitkraken ];
        };
    };
}
