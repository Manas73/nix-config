{ pkgs, lib, config, user_settings, ... }: {

    options = {
        slack.enable = lib.mkEnableOption "enables slack";
    };

    config = lib.mkIf config.slack.enable  {
        home.packages = with pkgs; [ slack ];
    };
}
