{ pkgs, lib, config, username, ... }: {

    options = {
        slack.enable = lib.mkEnableOption "enables slack";
    };

    config = lib.mkIf config.slack.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ slack ];
        };
    };
}
