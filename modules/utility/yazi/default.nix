{ pkgs, lib, config, username, ... }: {

    options = {
        yazi.enable = lib.mkEnableOption "enables yazi";
    };

    config = lib.mkIf config.yazi.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ yazi ];
        };
    };
}
