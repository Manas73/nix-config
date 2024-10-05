{ pkgs, lib, config, user_settings, ... }: {

    options = {
        yazi.enable = lib.mkEnableOption "enables yazi";
    };

    config = lib.mkIf config.yazi.enable  {
        home.packages = with pkgs; [ yazi ];
    };
}
