{ pkgs, lib, config, user_settings, ... }: {

    options = {
        gitkraken.enable = lib.mkEnableOption "enables gitkraken";
    };

    config = lib.mkIf config.gitkraken.enable  {
        home.packages = with pkgs; [ gitkraken ];
    };
}
